# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# OpenSSH LPK key lookup security
#
class openssh::lpk(

  $packages         = [ 'openssh-ldap' ],
  $user             = 'sshd',
  $group            = 'sshd',
  $uid              = undef,
  $gid              = undef,

) inherits openssh {

  clabs::install { $packages:; }

  # Standard RPM installations for this create usable user
  # and group (sshd:sshd) for this.  The following is really
  # a legacy configuration and really is not necessary.

#    group {
#      $group:
#        ensure      => 'present',
#        gid         => $gid,
#        forcelocal  => true,
#    }
#    clabs::user {
#      $user:
#        comment     => 'Privilege-separated SSH',
#        ensure      => 'present',
#        managehome  => false,
#        uid         => $uid,
#        gid         => $gid,
#        shell       => '/sbin/nologin',
#        password    => '!!',
#        system      => true,
#        home        => '/var/empty/sshd',
#        require     => Group[$group],
#    }

  clabs::template { '/etc/ssh/ldap.conf':
    owner   => $user,
    group   => $group,
    mode    => '440',
    notify  => Service[$svc],
  }

}
