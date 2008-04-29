#######################################
# syslog module
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
#######################################


# modules_dir { "syslog": }
class syslog {
    case $operatingsystem {
        centos: { include syslog::centos }
        default: { include syslog::base }
    }
}

class syslog::base {
    package{syslog:
        ensure => present,
    }

    service{syslog:
        ensure => running,
        hasstatus => true,
        require => Package[syslog],
    }
}

class syslog::centos inherits {
    Package[syslog]{
        name => 'sysklogd',
    }
    include syslog::pbpfixes
}
