#!/usr/bin/perl -w

$sx=0; $sy=0;
$rx=0; $ry=0;

$visited{$rx.','.$ry}++;

$santa=1;

while(<>) {
    chomp;
    foreach $a (split(//, $_)) {
        if($santa){
            if($a eq '>') { $sx++; }
            if($a eq '<') { $sx--; }
            if($a eq '^') { $sy++; }
            if($a eq 'v') { $sy--; }
            $visited{$sx.','.$sy}++;
            $santa=0;
        } else {
            if($a eq '>') { $rx++; }
            if($a eq '<') { $rx--; }
            if($a eq '^') { $ry++; }
            if($a eq 'v') { $ry--; }
            $visited{$rx.','.$ry}++;
            $santa=1;
        }
    }
}
print "visited ", scalar keys %visited, "\n";

