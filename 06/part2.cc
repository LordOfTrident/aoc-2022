#include <iostream>
#include <fstream>
#include <string>

int main() {
	std::ifstream f("input.txt");
	if (not f.is_open()) {
		std::cerr << "Could not open file 'input.txt'" << std::endl;

		return 1;
	}

	std::string line;
	f >> line;

	f.close();

	std::string seq;
	size_t      pos;
	for (pos = 0; pos < line.length(); ++ pos) {
		if (seq.length() == 14)
			break;

		if (seq.find_first_of(line[pos]) == std::string::npos) {
			seq += line[pos];

			continue;
		}

		seq  = seq.substr(seq.find_first_of(line[pos]) + 1);
		seq += line[pos];
	}

	std::cout << pos << std::endl;

	return 0;
}
