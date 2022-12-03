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
		line := scanner.Text()

		compartment1 := line[:len(line) / 2]
		compartment2 := line[len(line) / 2:]

		for _, ch := range compartment1 {
			if strings.Contains(compartment2, string(ch)) {
				sum += getPriority(ch)

				break
			}
		}
	}

	fmt.Println(sum)
}
