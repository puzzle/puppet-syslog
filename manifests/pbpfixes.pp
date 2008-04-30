#######################################
# syslog module - pbpfixes.pp
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
# puzzle best practices for syslog
#######################################

# ToDo: This should be managed all in a own config file
class syslog::pbpfixes {
    exec{syslog_firewall:
        command => 'echo "kern.warn  /var/log/firewall" >> /etc/syslog.conf',
        unless => 'grep -q "/var/log/firewall" /etc/syslog.conf',
        require => Package[syslog],
        notify => Service[syslog],
    }

    exec{console_logging:
        command => 'sed -i "s@\(KLOGD_OPTIONS=\)\"\(.*\)\"@\1\"\2 -c 4\"@g" /etc/sysconfig/syslog',
        unless => 'grep -q "KLOGD_OPTIONS.*-c 4" /etc/sysconfig/syslog',
        require => Package[syslog],
        notify => Service[syslog],
    }
 
}
