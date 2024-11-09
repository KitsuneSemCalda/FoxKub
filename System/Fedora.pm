package Fedora;

use strict;
use warnings;

use Term::ANSIColor;

sub install_new_cli_command {
  my ($app) = @_;
  
  system("sudo dnf install -y $app");

  if ($? == 0) {
    print colored("Sucessful installed $app\n", 'bold green');
    return 1;
  }

  print colored("Failed to install $app\n",'bold red');
  return 0;
}

sub update_system {
  system("sudo dnf update -y");

  if ($? == 0) {
    print colored("Sucessful update system\n", 'bold green');
    return 1;
  }

  print colored("Failed to update system\n", 'bold red');
  return 0;
}

sub add_repository {
    my ($repo_name, $repo_url, $gpg_url) = @_;
    my $repo_file_path = "/etc/yum.repos.d/$repo_name.repo";
    
    my $repo_content = <<"EOF";
[$repo_name]
name=$repo_name
baseurl=$repo_url
enabled=1
gpgcheck=1
gpgkey=$gpg_url
EOF

    if (open my $fh, "|-", "sudo tee $repo_file_path") {
        print $fh $repo_content;
        close $fh;
        print colored("Repository file $repo_file_path created successfully.\n", 'bold green');
    } else {
        print colored("Failed to create repository file $repo_file_path.\n", 'bold red');
        return 0;
    }

    # Importa a chave GPG
    if (system("sudo rpm --import $gpg_url") == 0) {
        print colored("GPG key imported successfully from $gpg_url.\n", 'bold green');
        update_system();
        return 1;
    } else {
        print colored("Failed to import GPG key from $gpg_url.\n", 'bold red');
        return 0;
    }
}

1;
