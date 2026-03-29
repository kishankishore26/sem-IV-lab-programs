#!/usr/bin/perl

foreach $num (@ARGV)
{
$sum = 0;
$a = $num;
	until( $num == 0)
	{
		$y = $num % 10;
		$sum = $sum + $y;
		$num = ( $num / 10);
	}
	print "Sum of $a is: $sum\n";
}
