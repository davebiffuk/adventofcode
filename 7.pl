#!/usr/bin/perl -w

#use bigint;
#use integer;
use strict;
use Data::Dumper;
use Memoize;

my %wire;
my $wanted = shift || 'a';

while(<>) {
    chomp;
    if(m/^\s*(.+)\s+->\s+(\S+)/) {
        if(defined($wire{$2})) {
            die "already had a rule for ".$2." (".$wire{$2}.")\n";
        }
        $wire{$2}=$1;
    } else {
        die "can't parse this: $_\n";
    }
}

#print Dumper(%wire), "\n";
#exit;

sub valueof {
    my $w = shift;

    if(!defined($wire{$w})) { die "no rule for '".$w."'\n"; }
    my $r = $wire{$w};

#    print "<", $w, "> = <", $r, ">\n";

    if($r =~ m/^(\d+)$/) {
        return($1);
    }
    if($r =~ m/^(\S+)$/) {
        return(valueof($1));
    }
    if($r =~ m/^(\d+) AND (\S+)$/) {
        my $a=$1; my $b=$2;
        return(int($a) & int(valueof($b)));
    }
    if($r =~ m/^(\S+) AND (\S+)$/) {
        my $a=$1; my $b=$2;
        return(int(valueof($a)) & int(valueof($b)));
    }
    if($r =~ m/^(\S+) OR (\S+)$/) {
        my $a=$1; my $b=$2;
        return(int(valueof($a)) | int(valueof($b)));
    }
    if($r =~ m/^(\S+) LSHIFT (\d+)$/) {
        my $a=$1; my $b=$2;
        return(int(valueof($a)) << int($b));
    }
    if($r =~ m/^(\S+) RSHIFT (\d+)$/) {
        my $a=$1; my $b=$2;
        return(int(valueof($a)) >> int($b));
    }
    if($r =~ m/^NOT (\S+)$/) {
        return((~int(valueof($1))) & (2**16-1));
    }
}

memoize('valueof');

print "wire $wanted = ", valueof("$wanted"), "\n";
#print "wire b = ", valueof("b"), "\n";
#print "wire f = ", valueof("f"), "\n";
#print "wire lu = ", valueof("lu"), "\n";
#foreach $i ("d", "e", "f", "g", "h", "i", "x", "y") {
#    print "wire $i = ", valueof($i), "\n";
#}
