local file = io.open("input.txt")

-- Parsing the stacks
local stackLines = {}
while true do
	local line = file:read()
	if #line == 0 then
		break
	end

	stackLines[#stackLines + 1] = line
end

local stackNumbers = stackLines[#stackLines]
stackLines[#stackLines] = nil

local stacks = {}
while true do
 	local start, end_ = string.find(stackNumbers, "%d+")
	if start == nil or end_ == nil then
		break
	end

	stackNumbers        = string.sub(stackNumbers, end_ + 1)
	stacks[#stacks + 1] = {}
end

for i = #stackLines, 1, -1  do
	local next = 0
	while true do
		local start, end_ = string.find(stackLines[i], "[%a]", next)
		if start == nil or end_ == nil then
			break
		end

		local stack = stacks[math.floor((start - 2) / 4) + 1]
		stack[#stack + 1] = string.sub(stackLines[i], start, end_)

		next = end_ + 1
	end
end

-- Helper functions
function moveCrates(count, from, to)
	local len = #stacks[from]

	for i = 1, count do
		stacks[to][#stacks[to] + 1] = stacks[from][len - (count - i)]
		stacks[from][len - (count - i)] = nil
	end
end

function get(s, word)
	local start, end_ = string.find(s, word .. " %d+")

	return tonumber(string.sub(s, start + #word + 1, end_))
end

-- Parsing the moves
while true do
	local line = file:read()
	if line == nil then
		break
	end

	moveCrates(get(line, "move"), get(line, "from"), get(line, "to"))
end

for _, stack in pairs(stacks) do
	io.write(stack[#stack])
end

print()
