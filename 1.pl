#!/usr/bin/perl -w

$floor=0;
$count=0;
$pos=-1;

while(<>) {
    chomp;
    foreach $a (split(//, $_)) {
        if($a eq '(') { $floor++; }
        if($a eq ')') { $floor--; }
        $count++;
        print "after ", $count, ":\t", $floor, "\n";
        if (($floor == -1) && ($pos == -1)) { $pos=$count; }
    }
}
print "entered basement at ", $pos, "\n";
