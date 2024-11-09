use strict;
use warnings;

use lib './System';

use Gnome;
use Fedora;
use Term::ANSIColor;

my $current_desktop = $ENV{"XDG_CURRENT_DESKTOP"};

unless ( $current_desktop eq "GNOME" ) {
  print colored("The Desktop Enviroment needed is GNOME\n", 'bold red');
  exit 1;
}

sub main {
  Gnome::set_gnome_setting("org.gnome.desktop.screensaver", "lock-enabled", "false");
  Gnome::set_gnome_setting("org.gnome.desktop.session", "idle-delay", 0);
  
  Fedora::add_repository('charm', 'https://repo.charm.sh/yum/', 'https://repo.charm.sh/yum/gpg.key');
  Fedora::update_system();
  Fedora::install_new_cli_command("gum");

  Gnome::set_gnome_setting("org.gnome.desktop.screensaver", "lock-enabled", "true");
  Gnome::set_gnome_setting("org.gnome.desktop.session", "idle-delay", 300);
}

main()
