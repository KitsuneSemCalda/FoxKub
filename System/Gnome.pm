package Gnome;

use strict;
use warnings;

use Term::ANSIColor;

sub set_gnome_setting {
  my ($schema, $key, $value) = @_;
  if(system("gsettings set $schema $key $value") == 0){
    print colored("Sucessful set $schema $key $value\n", 'bold green');
  }else {
    print colored("Failed to set $schema $key $value\n", 'bold red');
  }
}

1;
