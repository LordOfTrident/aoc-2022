program AOC_01_2;

uses sysutils;

type LongIntArray = array of LongInt;

var
	caloriesList: LongIntArray;
	calories:     LongInt;

	i, j: Word;

	top3: array [0..2] of LongInt = (0, 0, 0);
	sum:  LongInt = 0;

	f:    Text;
	line: String;
	back: Word = 0;

begin
	SetLength(caloriesList, 1);

	// Read the input file
	Assign(f, 'input.txt');
	Reset(f);

	while true do
	begin
		ReadLn(f, line);

		if EOF(f) then
		begin
			caloriesList[back] += StrToInt(line);

			break;
		end
		else if Length(line) = 0 then
		begin
			SetLength(caloriesList, Length(caloriesList) + 1);

			back := Length(caloriesList) - 1;
			caloriesList[back] := 0;
		end
		else
		begin
			caloriesList[back] += StrToInt(line);
		end;
	end;

	Close(f);

	// Calculate the top 3 elves
	for calories in caloriesList do
	begin
		for i := 0 to Length(top3) - 1 do
		begin
			if calories > top3[i] then
			begin
				for j := Length(top3) - 2 downto i do
					top3[j + 1] := top3[j];

				top3[i] := calories;

				break;
			end;
		end;
	end;

	for i := 0 to Length(top3) - 1 do
		sum += top3[i];

	WriteLn(sum);
end.
