#
# syslog module
#
# Copyright 2008, Puzzle ITC GmbH
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi josi+puppet(at)puzzle.ch
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

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
        enable => true,
        hasstatus => true,
        require => Package[syslog],
    }
}

class syslog::centos inherits syslog::base {
    Package[syslog]{
        name => 'sysklogd',
    }
    include syslog::pbpfixes
}
