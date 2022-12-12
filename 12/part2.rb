# TODO: Clean up this awful ugly code that i had no energy to clean up right after writing

class Pos
	def initialize(x, y)
		@x = x
		@y = y
	end

	attr_accessor :x
	attr_accessor :y
end

def to_ascii(ch)
	return ch.codepoints[0]
end

$map = []

$end_ = Pos.new(0, 0)

# Parse

pos = Pos.new(0, 0)
File.readlines("input.txt").each do |line|
	$map.push([])

	line.codepoints do |c|
		if c == to_ascii("\n")
			break
		elsif c == to_ascii("S")
			c = to_ascii("a")
		elsif c == to_ascii("E")
			$end_ = Pos.new(pos.x, pos.y)

			c = to_ascii("z")
		end

		$map[$map.length() - 1].push(c - to_ascii("a"))

		pos.x += 1
	end

	pos.x  = 0
	pos.y += 1
end

$map_w = $map[0].length()
$map_h = $map.length()

$copy = []
$map.each do |row|
	$copy.push([])

	row.each do |h|
		$copy[$copy.length() - 1].push(h)
	end
end

def print_copy()
	$copy.each do |row|
	    row.each do |h|
	        print (h + to_ascii("a")).chr()
	    end

	    puts
	end
end

print_copy()

$visited = []

# Algorithm
def find_end(positions, steps)
	new_positions = []
	positions.each do |pos|
		h = $map[pos.y][pos.x]

		if not $visited.any?{|pos_a| pos_a.x == pos.x and pos_a.y == pos.y}
			$visited.push(Pos.new(pos.x, pos.y))
			$copy[pos.y][pos.x] = to_ascii(":") - to_ascii("a")
		end

		if pos.x + 1 < $map_w
			next_ = Pos.new(pos.x + 1, pos.y)

			if not new_positions.any?{|pos| pos.x == next_.x and pos.y == next_.y}
				if $map[next_.y][next_.x] + 1 >= h and
				   not $visited.any?{|pos| pos.x == next_.x and pos.y == next_.y}
					new_positions.push(next_)
					$copy[next_.y][next_.x] = to_ascii(" ") - to_ascii("a")

					# TODO: This return here causes the steps to be off by 1 and the visualization
					#       to be one step back
					if $map[next_.y][next_.x] == 0
						return steps
					end
				end
			end
		end
		if pos.x - 1 >= 0
			next_ = Pos.new(pos.x - 1, pos.y)

			if not new_positions.any?{|pos| pos.x == next_.x and pos.y == next_.y}
				if $map[next_.y][next_.x] + 1 >= h and
				   not $visited.any?{|pos| pos.x == next_.x and pos.y == next_.y}
					new_positions.push(next_)
					$copy[next_.y][next_.x] = to_ascii(" ") - to_ascii("a")

					if $map[next_.y][next_.x] == 0
						return steps
					end
				end
			end
		end
		if pos.y + 1 < $map_h
			next_ = Pos.new(pos.x, pos.y + 1)

			if not new_positions.any?{|pos| pos.x == next_.x and pos.y == next_.y}
				if $map[next_.y][next_.x] + 1 >= h and
				   not $visited.any?{|pos| pos.x == next_.x and pos.y == next_.y}
					new_positions.push(next_)
					$copy[next_.y][next_.x] = to_ascii(" ") - to_ascii("a")

					if $map[next_.y][next_.x] == 0
						return steps
					end
				end
			end
		end
		if pos.y - 1 >= 0
			next_ = Pos.new(pos.x, pos.y - 1)

			if not new_positions.any?{|pos| pos.x == next_.x and pos.y == next_.y}
				if $map[next_.y][next_.x] + 1 >= h and
				   not $visited.any?{|pos| pos.x == next_.x and pos.y == next_.y}
					new_positions.push(next_)
					$copy[next_.y][next_.x] = to_ascii(" ") - to_ascii("a")

					if $map[next_.y][next_.x] == 0
						return steps
					end
				end
			end
		end
	end

	puts "\e[%dA\r" % ($map_h + 1)
	print_copy()

	positions = []

	return find_end(new_positions, steps + 1)
end

puts find_end([$end_], 0) + 1
