import strutils
import std/re

type
    Monkey = object
        items: seq[int]

        left:  string
        op:    string
        right: string

        test:    int
        ifTrue:  int
        ifFalse: int

        inspected: int
    MonkeyRef = ref Monkey

var
    monkeys = newSeq[MonkeyRef]()
    counter = 0
    monkey  = MonkeyRef()

# Parse input
var prefixes: array[7, string] = [
    "",
    "  Starting items: ",
    "  Operation: new = ",
    "  Test: divisible by ",
    "    If true: throw to monkey ",
    "    If false: throw to monkey ",
    "",
]

for line in lines "input.txt":
    var line = line[prefixes[counter].len .. line.len - 1]

    case counter:
    of 0: discard
    of 1:
        var all = findAll(line, re"[0-9]+")
        for one in all:
            monkey.items.add(parseInt(one))
    of 2:
        var sides = findAll(line, re"[0-9a-z]+")
        monkey.left  = sides[0]
        monkey.right = sides[1]

        var ops = findAll(line, re"[\*\+]")
        monkey.op = ops[0]
    of 3:
        monkey.test = parseInt(line)
    of 4:
        monkey.ifTrue = parseInt(line)
    of 5:
        monkey.ifFalse = parseInt(line)
    of 6:
        counter = 0

        monkeys.add(monkey)
        monkey = MonkeyRef()

        continue
    else: discard

    counter += 1

# Add the last monkey
monkeys.add(monkey)

var modVal: int = 1
for monkey in monkeys:
    modVal = modVal * monkey.test

proc monkeyRound(monkey: MonkeyRef) =
    if monkey.items.len == 0:
        return

    while monkey.items.len > 0:
        var
            left:  int
            right: int

        if monkey.left == "old":
            left = monkey.items[0]
        else:
            left = parseInt(monkey.left)

        if monkey.right == "old":
            right = monkey.items[0]
        else:
            right = parseInt(monkey.right)

        case monkey.op:
        of "*":
            monkey.items[0] = left * right
        of "+":
            monkey.items[0] = left + right
        else: discard

        monkey.items[0] = monkey.items[0] mod modVal

        if monkey.items[0] mod monkey.test == 0:
            monkeys[monkey.ifTrue].items.add(monkey.items[0])
        else:
            monkeys[monkey.ifFalse].items.add(monkey.items[0])

        monkey.items.delete(0)

        monkey.inspected += 1


# Rounds
var rounds = 10000

for round in 1 .. rounds:
    for monkeyIdx in 0 .. monkeys.len - 1:
        monkeyRound(monkeys[monkeyIdx])

var
    first:  int = 0
    second: int = 0
for monkey in monkeys:
    if monkey.inspected > first:
        second = first
        first  = monkey.inspected
    elif monkey.inspected > second:
        second = monkey.inspected

# Monkey business
echo first * second
