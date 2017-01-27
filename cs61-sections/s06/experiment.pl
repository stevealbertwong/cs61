#! /usr/bin/perl
use Time::HiRes qw(time);
$throwout = 1;

sub stats (@) {
  my($sum, $sumsq, $n) = (0, 0, 0);
  my(@x) = sort {$a <=> $b} @_;
  @x = @x[1..(@x - 2)] if $throwout && @x > 2;
  foreach my $i (@x) {
    $sum += $i;
    $sumsq += $i * $i;
    $n += 1;
  }
  return {} if ($n == 0);
  return {"mean" => $sum / $n,
	  "stddev" => $n > 1 ? sqrt(($sumsq - $sum * $sum / $n) / ($n - 1)) : 0,
	  "min" => $x[0],
	  "max" => $x[scalar(@x) - 1],
	  "median" => (@x % 2 ? 0.5 * ($x[int(@x/2)] + $x[int(@x/2) + 1]) : $x[int(@x/2)])};
}

%runs = ();
$nruns = 6;
@codes = ("list", "vector", "tree");
@sizes = (5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000, 10000, 20000, 50000, 100000);
$top = $sizes[@sizes - 1];
$top = $ARGV[0] if @ARGV && $ARGV[0] =~ /\A\d+\z/;

foreach my $i (@sizes) {
  next if $i > $top;
  print STDERR "$i";
  foreach my $j (@codes) {
    $runs{$j} = {} if !exists $runs{$j};
    $runs{$j}->{$i} = [];
    for ($runs = 0; $runs < ($i <= 2000 ? 10 : $nruns); ++$runs) {
      $a = time();
      system("./numwave-$j $i");
      $b = time();
      push @{$runs{$j}->{$i}}, $b - $a;
      print STDERR ".";
    }
  }
  print STDERR "\n";
}

print "set terminal png
set logscale x
set logscale y
set bars small
set key top left Left reverse
set xlabel 'N (maximum set size)'
set ylabel 'Time to add and then remove N items (sec)'\n";
@plots = ();
$k = 0;
foreach my $j (@codes) {
  $k += 1;
  push @plots, "'-' with errorbars title '$j' ls $k pt 1, '-' with lines notitle ls $k";
}
print "plot ", join(", ", @plots), "\n";
foreach my $j (@codes) {
  foreach my $i (@sizes) {
    next if $i > $top;
    my $x = stats(@{$runs{$j}->{$i}});
    print $i, " ", $x->{mean}, " ", $x->{"min"}, " ", $x->{"max"}, "\n";
  }
  print "e\n";
  foreach my $i (@sizes) {
    next if $i > $top;
    my $x = stats(@{$runs{$j}->{$i}});
    print $i, " ", $x->{mean}, "\n";
  }
  print "e\n";
}
