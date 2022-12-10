using System;

class AOC_10_2
{
	static int rx     = 1;
	static int inst   = 0;
	static int op     = 0;
	static int cycles = 0;
	static int cycle  = 0;
	static int sum    = 0;
	static int x      = 0;

	static void Main(string[] args)
	{
		foreach (string line in System.IO.File.ReadLines("input.txt"))
		{
			string[] toks = line.Split(' ');

			switch (toks[0])
			{
			case "noop":
				cycles = 1;
				inst   = 0;

				break;

			case "addx":
				cycles = 2;
				inst   = 1;
				op     = Int32.Parse(toks[1]);

				break;
			}

			while (cycles > 0)
			{
				++ cycle;

				System.Console.Write(x >= rx - 1  && x <= rx + 1? "#" : ".");
				++ x;

				if ((cycle - 20) % 40 == 0)
				{
					sum += rx * cycle;
				}

				if (cycle % 40 == 0)
				{
					System.Console.WriteLine();
					x = 0;
				}

				Cycle();
			}
		}
	}

	static void Cycle()
	{
		-- cycles;
		if (cycles > 0)
		{
			return;
		}

		switch (inst)
		{
		case 0: break;
		case 1: rx += op; break;
		}
	}
}
