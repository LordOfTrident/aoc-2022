const fs = require("fs");

let sum      = 0
let contents = fs.readFileSync("input.txt", "utf-8")

function leftContainsRight(left, right) {
	return right.first >= left.first && right.last <= left.last
}

contents.split("\n").forEach(line => {
	if (line.length == 0)
		return

	let elves = line.split(",")

	let tmp = elves[0].split("-")
	elves[0] = {
		"first": parseInt(tmp[0]),
		"last":  parseInt(tmp[1])
	}

	tmp = elves[1].split("-")
	elves[1] = {
		"first": parseInt(tmp[0]),
		"last":  parseInt(tmp[1])
	}

	if (leftContainsRight(elves[0], elves[1]) || leftContainsRight(elves[1], elves[0]))
		++ sum
})

console.log(sum)
