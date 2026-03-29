#!/usr/bin/perl

print "\nEnter the input string:";
$a = <STDIN>;

print "\nEnter total number of times the string to be displayed:";
chop( $b = <STDIN> );

$c = $a x $b;
print "Result is :\n$c";
