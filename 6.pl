#!/usr/bin/perl -w

use Data::Dumper;

while(<>) {
    chomp;
    if(m/turn on/) { $mode="on"; }
    if(m/turn off/) { $mode="off"; }
    if(m/toggle/) { $mode="toggle"; }
    if(m/(\d+),(\d+) through (\d+),(\d+)/) { $x1=$1; $y1=$2;
        $x2=$3; $y2=$4; } else {
        print "couldn't find co-ords in: $_\n";
        exit;
    }
    foreach $x ($x1..$x2) {
        foreach $y ($y1..$y2) {
            if($mode eq "on") { $grid[$x][$y]++; }
            if($mode eq "off") {
                $grid[$x][$y]--;
                if($grid[$x][$y]<0) { $grid[$x][$y]=0; }
            }
            if($mode eq "toggle") {
                #if(defined($grid[$x][$y])) { $grid[$x][$y]=1-$grid[$x][$y]; }
                #else { $grid[$x][$y]=1; }
                $grid[$x][$y]+=2;
            }
        }
    }
}

$count_lit = 0;
$bright=0;
foreach $x (0..999) {
        foreach $y (0..999) {
            if((defined($grid[$x][$y])) && ($grid[$x][$y] == 1)) { $count_lit++; }
            if(defined($grid[$x][$y])) { $bright+=$grid[$x][$y]; }
        }
    }
print "lit: ", $count_lit, "\n";
print "brightness: ", $bright, "\n";
