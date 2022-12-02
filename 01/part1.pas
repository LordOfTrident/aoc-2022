program AOC_01_1;

uses sysutils;

type LongIntArray = array of LongInt;

var
	caloriesList: LongIntArray;
	calories:     LongInt;

	most: LongInt = 0;

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

	for calories in caloriesList do
	begin
		if calories > most then
			most := calories;
	end;

	WriteLn(most);
end.
