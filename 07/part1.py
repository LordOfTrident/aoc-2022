from enum import Enum
import re

FileType = Enum("FileType", "File Dir")

class File:
    def __init__(self, type, parent, size):
        self.type   = type
        self.parent = parent
        self.files  = {} if type == FileType.Dir else None
        self.size   = size

def findDirSize(dir):
    dir.size = 0

    for name in dir.files:
        if dir.files[name].type == FileType.Dir:
            dir.size += findDirSize(dir.files[name])
        else:
            dir.size += dir.files[name].size

    return dir.size

file  = open("input.txt", "r")
lines = file.readlines()

root = File(FileType.Dir, None, None)
pwd  = root

for line in lines:
    line = line.strip()

    if line[0] == "$": # Is a command
        x = re.findall("cd|ls", line)

        if x[0] == "ls":
            continue

        # cd
        name = line[len(x[0]) + 3:]

        if name == "/":
            pwd = root
        elif name == "..":
            pwd = pwd.parent
        else:
            pwd = pwd.files[name]
    else: # Is a file
        x = re.findall("[0-9]+", line)

        if len(x) > 0: # Is not a directory
            name = line[len(x[0]) + 1:]
            size = int(x[0])

            pwd.files[name] = File(FileType.File, pwd, size)

        else: # Is a directory
            name = line[len("dir "):]

            pwd.files[name] = File(FileType.Dir, pwd, None)

findDirSize(root)

def sumSizesAbove(dir, x):
    sum = 0
    if dir.size <= x:
        sum += dir.size

    for name in dir.files:
        if dir.files[name].type == FileType.Dir:
            sum += sumSizesAbove(dir.files[name], x)

    return sum

print(sumSizesAbove(root, 100000))

