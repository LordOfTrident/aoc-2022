use strict;
use warnings;

my $file = "input.txt";
open my $info, $file or die "Error: Could not open file $file";

my $pos = 0;
my $str;

sub IsDigit {
	return $_[0] eq '0' || $_[0] eq '1' || $_[0] eq '2' || $_[0] eq '3' || $_[0] eq '4' ||
	       $_[0] eq '5' || $_[0] eq '6' || $_[0] eq '7' || $_[0] eq '8' || $_[0] eq '9';
}

sub NextData {
	my $char = substr($str, $pos, 1);
	if (IsDigit($char)) {
		my $num = '';
		while (IsDigit($char)) {
			$num  = $num . $char;
			$pos  = $pos + 1;
			$char = substr($str, $pos, 1);
		}

		return $num;
	} elsif ($char eq '[') {
		$pos  = $pos + 1;
		$char = substr($str, $pos, 1);

		my @data = ();
		while (not ($char eq ']')) {
			my @ret = NextData();

			if (ref(@ret) eq 'ARRAY') {
				push @data, \@ret;
			} else {
				push @data, @ret;
			}

			$char = substr($str, $pos, 1);
			if ($char eq ',') {
				$pos  = $pos + 1;
				$char = substr($str, $pos, 1);
			}
		}

		$pos = $pos + 1;

		return \@data;
	}
}

sub Compare {
	my $lIsArr;
	if (ref($_[0]) eq 'ARRAY') {
		$lIsArr = 1;
	} else {
		$lIsArr = 0;
	}

	my $rIsArr;
	if (ref($_[1]) eq 'ARRAY') {
		$rIsArr = 1;
	} else {
		$rIsArr = 0;
	}

	if ((not $lIsArr) and (not $rIsArr)) {
		my $l = $_[0];
		my $r = $_[1];

		if ($l > $r) {
			return 0;
		} elsif ($l < $r) {
			return 1;
		}
	} else {
		my @l;
		if ($lIsArr) {
			@l = @{$_[0]};
		} else {
			@l = ($_[0]);
		}

		my @r;
		if ($rIsArr) {
			@r = @{$_[1]};
		} else {
			@r = ($_[1]);
		}

		my $len = $#l;
		if ($#r < $len) {
			$len = $#r;
		}

		for my $i (0 .. $len) {
			my $res = Compare($l[$i], $r[$i]);
			if ($res != 2) {
				return $res;
			}
		}

		if ($#l < $#r) {
			return 1;
		} elsif ($#l > $#r) {
			return 0;
		}
	}

	return 2;
}

my $sum = 0;
my $idx = 1;
while (1) {
	my $a = <$info>;
	my $b = <$info>;
	if ((not $a) or (not $b)) {
		last;
	}

	$str = $a;
	$pos = 0;
	my @aData = NextData();

	$str = $b;
	$pos = 0;
	my @bData = NextData();

	if (Compare(@aData, @bData)) {
		$sum = $sum + $idx;
	}

	$idx = $idx + 1;

	my $skip = <$info>;
	if (not $skip) {
		last;
	}
}

close $info;

print $sum, "\n";
