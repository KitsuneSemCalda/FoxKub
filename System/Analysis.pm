package Analysis;

use strict;
use warnings;

sub get_cpu_cores {
  my $cores = `nproc --all`;
  chomp $cores;
  return $cores;
}

sub get_total_memory {
  my $mem_info = `grep MemTotal /proc/meminfo`;
  if ($mem_info =~ /(\d+)/){
    my $mem_info_kb = $1;
    my $mem_info_mb = int($mem_info_kb / 1024);
    return $mem_info_mb;
  }

  return undef
}

sub is_fedora {
  if ( -e '/etc/fedora-release') {
    return 1;
  }else {
    my $release_info = `cat /etc/os-release`;
    if ($release_info =~ /fedora|red hat/i) {
      return 1;
    }
  }

  return 0;
}

sub get_system_info {
    my $cpu_cores = get_cpu_cores();
    my $total_memory = get_total_memory();
    my $is_fedora = is_fedora() ? "Sim" : "Não";
    
    print "Informações do Sistema:\n";
    print "Núcleos de CPU: $cpu_cores\n";
    print "Memória Total (MB): $total_memory\n";
    print "É Fedora?: $is_fedora\n";
}

1;
