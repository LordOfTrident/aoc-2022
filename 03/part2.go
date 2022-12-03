package main

import (
	"fmt"
	"os"
	"bufio"
	"strings"
)

func getPriority(ch rune) int {
	if (ch >= 'a' && ch <= 'z') {
		return int(ch) - int('a') + 1
	} else if (ch >= 'A' && ch <= 'Z') {
		return int(ch) - int('A') + 27
	} else {
		panic(fmt.Errorf("Invalid char '%v'", string(ch)))
	}
}

func main() {
	f, err := os.Open("input.txt")
	if err != nil {
		fmt.Fprintf(os.Stderr, "Error: %v", err.Error())

		os.Exit(1)
	}
	defer f.Close()

	sum := 0

	scanner := bufio.NewScanner(f)
	for scanner.Scan() {
		elves := []string{}

		for i := 0; i < 3; i ++ {
			if i != 0 {
				scanner.Scan()
			}

			elves = append(elves, scanner.Text())
		}

		for _, ch := range elves[0] {
			found := true
			for i := 1; i < 3; i ++ {
				if !strings.Contains(elves[i], string(ch)) {
					found = false

					break
				}
			}

			if found {
				sum += getPriority(ch)

				break
			}
		}
	}

	fmt.Println(sum)
}
