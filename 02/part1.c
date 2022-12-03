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

enum outcome get_outcome(enum type p_opponent, enum type p_you) {
	if (p_opponent == p_you)
		return DRAW;
	else if ((p_opponent == SCISSORS && p_you == ROCK) ||
	         (p_opponent == PAPER    && p_you == SCISSORS) ||
	         (p_opponent == ROCK     && p_you == PAPER))
		return WON;
	else
		return LOST;
}

int main(void) {
	FILE *f = fopen("input.txt", "r");
	if (f == NULL)
		assert(0 && "Failed to open 'input.txt'");

	int score = 0;

	char line[LINE_LEN];
	while (fgets(line, LINE_LEN, f) != NULL) {
		if (strlen(line) < 3)
			continue;

		enum type    opponent = line[0] - 'A';
		enum type    you      = line[2] - 'X';
		enum outcome outcome  = get_outcome(opponent, you);

		score += you + 1 + outcome * 3;
	}

	printf("%i\n", score);

	fclose(f);
}
