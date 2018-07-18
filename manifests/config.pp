# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class openssh::config inherits openssh {

  # Main Server Configuration
  clabs::template { '/etc/ssh/sshd_config':
    notify  => Service[$svc],
  }

}

