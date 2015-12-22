#!/usr/bin/perl -w

$nice=0;

#foreach $test ("ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp",
#    "haegwjzuvuyypxyu", "dvszwmarrgswjxmb") {
#foreach $test ("qjhvhtzxzqqjkmpb", "xxyxx", "uurcxstgmygtbstg",
#    "ieodomkazucvgmuy") {
while(<>) {
    chomp;
    $test=$_;
    print $test, "\t";
    if(isnice2($test)) {
        print "nice";
        $nice++;
    } else {
        print "naughty";
    }
    print "\n";
}

print "nice = ", $nice, "\n";


sub isnice1 {
    my $str = shift;

    # at least 3 vowels? (can be repeats)
    $v=$str;
    $v =~ y/aeiou//cd;
    if($v !~ m/.../) { return undef; }

    # at least one letter twice in a row
    if($str !~ m/(.)\1/) { return undef; }

    # does not contain the strings ab, cd, pq, or xy
    if(($str =~ m/ab/) || ($str =~ m/cd/) || ($str =~ m/pq/) ||
        ($str =~ m/xy/)) { return undef; }

    return 1;
}

sub isnice2 {
    my $str = shift;

    # a pair of any two letters that appears at least twice in the string without overlapping
    if($str !~ m/(..).*\1/) { return undef; }

    # at least one letter which repeats with exactly one letter between them
    if($str !~ m/(.).\1/) { return undef; }

    return 1;
}

