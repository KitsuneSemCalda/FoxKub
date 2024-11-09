use strict;
use warnings;

use Term::ANSIColor;
use Term::ReadKey;

my $home_dir = $ENV{'HOME'} // die "Not found the user home";
my $target_dir = "$home_dir/.local/share/foxkub";
my $repository = "https://github.com/KitsuneSemCalda/FoxKub";
my $install_script = "$target_dir/install.pl";

sub check_if_fedora {
    open my $os_release, '<', '/etc/os-release' or die colored("Failed to open /etc/os-release: $!\n", 'bold red');

    while (my $line = <$os_release>) {
        if ($line =~ /ID=fedora/i) {
            close $os_release;
            return 1;
        }
    }

    close $os_release;
    return 0;
}

sub print_foxkub_ascii {
    my $art = <<'END_ART';
  _____ _ __ _      
  | ___|____ _| |/ / _| |__   
  | |_ / _ \ \/ / ' / | | | '_\ 
  | _| (_) > <| . \ |_| | |_) | 
  |_| \___/_/\_\_|\_\__,_|_.__/
END_ART

    my ($width) = GetTerminalSize();

    my @lines = split /\n/, $art;

    my $max_width = 0;

    foreach my $line (@lines) {
        $max_width = length($line) if length($line) > $max_width;
    }

    foreach my $line (@lines) {
        my $padding = ' ' x (($width - $max_width) / 2);
        print $padding, colored($line, 'bold yellow'), "\n";
    }
}

sub check_if_git_exists {
    my $check_git = `git --version 2>&1`;
    return $? == 0;
}

sub clean_target_dir {
    if (-d "$target_dir") {
        print colored("Cleaning up the existing target directory...\n", 'bold yellow');
        my $result = `rm -rf $target_dir 2>&1`;
        if ($? != 0) {
            die colored("Failed to clean target directory: $result\n", 'bold red');
        }
    }
}

sub clone_repository {
    clean_target_dir();
    print colored("Cloning the repository...\n", 'bold yellow');
    my $clone_cmd = `git clone $repository $target_dir 2>&1`;
    if ($? == 0) {
        print colored("Repository cloned successfully!\n", 'bold green');
    } else {
        die colored("Failed to clone repository:\n$clone_cmd", 'bold red');
    }
}

sub update_repo {
    print colored("Updating repositories...\n", 'bold yellow');
    my $result = `sudo dnf update -y 2>&1`;
    if ($? != 0) {
        die colored("Failed to update repositories: $result\n", 'bold red');
    }
}

sub install_git {
    print colored("Git is not installed, installing Git...\n", 'bold yellow');
    my $result = `sudo dnf install -y git 2>&1`;
    if ($? != 0) {
        die colored("Failed to install Git: $result\n", 'bold red');
    }
}

sub run_install_script {
  if (-e $install_script) {
    print colored("Running install script: $install_script",'bold cyan');
    my $run_cmd = `perl $install_script 2>&1`;
    if ($? != 0) {
      die colored("Failed to execute install_script:\n$run_cmd", 'bold red');
      exit 1
    }
  }else {
    print colored("Install script not found at $install_script. Aborting\n", 'bold red');
    exit 1
  }
}

sub main{
  if (! check_if_fedora()) {
    print colored("This distro is builded to be used in fedora\n", 'bold red');
    exit 1
  }

  print_foxkub_ascii();
  update_repo();
  
  if (! check_if_git_exists()) {
    install_git();
  }

  clone_repository();
  run_install_script();
}

main();
