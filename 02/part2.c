#include <stdio.h>
#include <string.h>
#include <assert.h>

#define LINE_LEN 4

enum type {
	ROCK = 0,
	PAPER,
	SCISSORS
};

enum outcome {
	LOST = 0,
	DRAW,
	WON
};

enum type type_required_for_outcome(enum type p_opponent, enum outcome p_outcome) {
	switch (p_outcome) {
	case DRAW: break;

	case LOST:
		if (p_opponent <= ROCK)
			p_opponent = SCISSORS;
		else
			-- p_opponent;

		break;

	case WON:
		if (p_opponent >= SCISSORS)
			p_opponent = ROCK;
		else
			++ p_opponent;

		break;

	default: assert(0 && "UNREACHABLE");
	}

	return p_opponent;
}

int main(void) {
	FILE *f = fopen("input.txt", "r");
	if (f == NULL) {
		fputs("Failed to open input file 'input.txt'\n", stderr);

		return 1;
	}

	int score = 0;

	char line[LINE_LEN];
	while (fgets(line, LINE_LEN, f) != NULL) {
		if (strlen(line) < 3)
			continue;

		enum type    opponent = line[0] - 'A';
		enum outcome outcome  = line[2] - 'X';
		enum type    you      = type_required_for_outcome(opponent, outcome);

		score += you + 1 + outcome * 3;
	}

	printf("%i\n", score);

	fclose(f);
}
