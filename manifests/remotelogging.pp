#######################################
# syslog module - remotelogging.pp
# Puzzle ITC - haerry+puppet(at)puzzle.ch
# GPLv3
# manages remotelogging stuff
#######################################

# ToDo: This should be managed all in own
# config file
class syslog::remotelogging {

    $real_remote_logging_host = $remote_logging_host ? {
        '' => 'cairoi.ww2.ch',
        default => $remote_logging_host
    }
    
    exec{enable_remotelogging:
        command => "echo '*.* @'${real_remote_logging_host} >> /etc/syslog.conf",
        unless => "grep -q ${real_remote_logging_host} /etc/syslog.conf",
        require => Package[syslog],
        notify => Service[syslog],
    }
}
