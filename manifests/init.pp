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

    file{'/etc/syslog.conf':
        source => [ "puppet://$server/files/syslog/config/${fqdn}/syslog.conf", 
                    "puppet://$server/files/syslog/config/syslog.conf.${opratingsystem}",
                    "puppet://$server/files/syslog/config/syslog.conf", 
                    "puppet://$server/syslog/config/syslog.conf.${opratingsystem}",
                    "puppet://$server/syslog/config/syslog.conf"],
        notify => Service['syslog'],
        require => Package['syslog'],
        owner => root, group => 0, mode => 0644;
    }

    service{syslog:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package['syslog'],
    }
}

class syslog::centos inherits syslog::base {
    Package[syslog]{
        name => 'sysklogd',
    }

    files{'/etc/sysconfig/syslog':
        source => [ "puppet://$server/files/syslog/config/CentOS/${fqdn}/syslog", 
                    "puppet://$server/files/syslog/config/CentOS/syslog.${lsbdistrelease}", 
                    "puppet://$server/files/syslog/config/CentOS/syslog", 
                    "puppet://$server/files/config/CentOS/syslog.${lsbdistrelease}", 
                    "puppet://$server/syslog/config/CentOS/syslog" ],
        notify => Service['syslog'],
        owner => root, group => 0, mode => 0644;
    }
}
