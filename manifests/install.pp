# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# OpenSSH Installation
#
class openssh::install inherits openssh {

  if $::osfamily == 'RedHat' {
    ensure_packages(['redhat-lsb'])
  }

}

