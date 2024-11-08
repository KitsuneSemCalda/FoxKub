package Ascii;

use strict;
use warnings;

use Term::ANSIColor;
use POSIX qw/ceil/;

sub show_foxkub_ascii {
    my $text = <<'EOF';
_____ _ __ _      
| ___|____ _| |/ / _| |__   
| |_ / _ \ \/ / ' / | | | '_\ 
| _| (_) > <| . \ |_| | |_) | 
|_| \___/_/\_\_|\_\__,_|_.__/ 
EOF

    my $orange = color('yellow bold');

    my $cols = `tput cols`;
    chomp $cols;

    my $max_length = 0;
    my @lines = split("\n", $text);
    foreach my $line (@lines) {
        $max_length = length($line) if length($line) > $max_length;
    }

    my $padding = ceil(($cols - $max_length) / 2);

    foreach my $line (@lines) {
        print ' ' x $padding . $orange . $line . color('reset') . "\n";
    }
}


1; # Return true to indicate successful module loading
