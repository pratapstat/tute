#! /usr/bin/perl -w

use strict;

open FH,"fileList";

chomp(my @array=<FH>);

#my @array = @ARGV ? @ARGV : qw/SGH10_WT_G300__1.snps.filt.vcf.gz SGH10_WT_G300__2.snps.filt.vcf.gz SGH10_WT_G300__3.snps.filt.vcf.gz/;

sub fac {
   my $nr = shift;
   return 1 if $nr < 2;
   return $nr*fac($nr-1);
}

my %seen;
my $max = fac(scalar @array);
my $nr  = 0;
while( $nr < $max ) {
    my $need_combo = 1;
    my @combo;
    while( $need_combo ) {
        for( my $i = 0; $i < scalar @array; ++$i ) {
            $combo[$i] = $array[ rand scalar @array ];
        }
        my %unique;
        my $unique = 1;
        for my $c ( @combo ) {
            if( ++$unique{$c} > 1 ) {
                $unique = 0;
            }
        }
        if( $unique == 1 ) {
            $need_combo = 0;
        }
    }

    if( exists $seen{ "@combo" } ) {
        next;
    }
    else {
        local $" = "\t";
       # print "@combo\n";
    }
    ++$seen{"@combo"};
    ++$nr;
}


my %hash;
foreach my $tmp (keys %seen)
{

#print "$tmp\n";

	my @tmp_arr=split(" ",$tmp);
	if(!(exists($hash{$tmp_arr[0]})))
	{
	$hash{$tmp_arr[0]}="$tmp";
		(my $uniqSNP_fileName = $tmp_arr[0]) =~ s/vcf.gz/unique.snps.filt.vcf/g;
	print "bcftools isec -C $tmp >$uniqSNP_fileName\n";
	}
	else
	{
	next;
	}
}

