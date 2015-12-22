#!/usr/bin/perl

use Digest::MD5 qw(md5_hex);

$key=<>;
chomp $key;

$i=1;

while(1) {
    $out=md5_hex($key.$i);
    if($out =~ m/^000000/) {
        print "\n", $i, "\n", $out, "\n";
        exit;
    }
    $i++;
    if($i =~ m/000$/) {
        print "\r", $i, "...";
    }
}
