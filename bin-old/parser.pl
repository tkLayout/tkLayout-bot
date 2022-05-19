#!/usr/bin/env perl

use strict;
use warnings;
use HTML::TableExtract;

sub compare_files {
    my ($filename1, $filename2) = @_;
    my $table1 = HTML::TableExtract->new(keep_html => 0, depth => 0, count => 3, br_translate => 0);
    $table1->parse_file($filename1);
    
    my $dict1 = {};
    for my $row ($table1->rows) {
	my $tag = shift @$row;
	$dict1->{$tag} = $row;
    }
    
    my $table2 = HTML::TableExtract->new(keep_html => 0, depth => 0, count => 3, br_translate => 0);
    $table2->parse_file($filename2);
    
    my $dict2 = {};
    for my $row ($table2->rows) {
	my $tag = shift @$row;
	next unless defined $tag;
	$dict2->{$tag} = $row;
    }
    for my $key (keys %$dict1) {
	next unless exists $dict2->{$key};
	my $list1 = $dict1->{$key};
	my $list2 = $dict2->{$key};
	my $res = ($list1->[0] eq $list2->[0]) && ($list1->[1] eq $list2->[1]) && ($list1->[2] eq $list2->[2]);
	next if $res;
	print "==> $key\n";
	print join(" ", @$list1), "\n";
	print join(" ", @$list2), "\n";
    }
}
die "Usage: $0 file1 file2\n" unless scalar(@ARGV) > 1;
my $f1 = shift;
my $f2 = shift;
compare_files($f1, $f2);
__END__
	
my $filename1 = q|/afs/cern.ch/work/d/dutta/public/TkLayout/checkHtml/layouts/repository-git-master/TechnicalProposal2014/indexpixel.html|;
my $filename2 = q|/afs/cern.ch/work/d/dutta/public/TkLayout/checkHtml/layouts/repository-git-dev/TechnicalProposal2014/indexpixel.html|;
    
