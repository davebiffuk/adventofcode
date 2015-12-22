#!/usr/bin/perl -w

$total=0;
$ribbon=0;

while(<>) {
    chomp;
    @dim=split(/x/, $_);
    @dims= sort { $a <=> $b } @dim;
    print join(" x ", @dims), "\n";
    $area=$dims[0]*$dims[1] + 2*($dims[0]*$dims[1] + $dims[1]*$dims[2] + $dims[2]*$dims[0]);
    $total += $area;
    $ribbon += 2*($dims[0]+$dims[1]) + $dims[0]*$dims[1]*$dims[2];
}
print "area = ", $total, "\n";
print "ribbon = ", $ribbon, "\n";
