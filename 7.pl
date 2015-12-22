#!/usr/bin/perl -w

#use bigint;
#use integer;

while(<>) {
    chomp;
    push @rules, $_;
}

$count=1;
do {
    $again=0;
    print "\rpass ", $count, "... ";
    foreach $_ (@rules) {
        if(m/^(\d+) -> (\S+)/) {
            $wire{$2} = int($1);
            next;
        }
        if(m/^(\S+) -> (\S+)/) {
            if(!defined($wire{$1})) { $again=1; next; }
            $wire{$2} = int($wire{$1});
            next;
        }
        if(m/^(\S+) AND (\S+) -> (\S+)/) {
            if(!defined($wire{$1})) { $again=1; next; }
            if(!defined($wire{$2})) { $again=1; next; }
            $wire{$3} = int($wire{$1}) & int($wire{$2});
            next;
        }
        if(m/^(\S+) OR (\S+) -> (\S+)/) {
            if(!defined($wire{$1})) { $again=1; next; }
            if(!defined($wire{$2})) { $again=1; next; }
            $wire{$3} = int($wire{$1}) | int($wire{$2});
            next;
        }
        if(m/^(\S+) LSHIFT (\d+) -> (\S+)/) {
            if(!defined($wire{$1})) { $again=1; next; }
            $wire{$3} = int($wire{$1}) << int($2);
            next;
        }
        if(m/^(\S+) RSHIFT (\d+) -> (\S+)/) {
            if(!defined($wire{$1})) { $again=1; next; }
            $wire{$3} = int($wire{$1}) >> int($2);
            next;
        }
        if(m/^NOT (\S+) -> (\S+)/) {
            if(!defined($wire{$1})) { $again=1; next; }
            $wire{$2} = (~int($wire{$1})) & (2**16-1);
            next;
        }
        print "couldn't parse line: ", $_, "\n";
        exit;
    }
    $count++;
} while ($again==1);

print "\n";

foreach $i (sort keys %wire) {
    print $i, ": ", int($wire{$i}), "\n";
}
