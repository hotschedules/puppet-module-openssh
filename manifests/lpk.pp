# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker
#
# OpenSSH LPK key lookup security
#
class openssh::lpk(

  $packages         = [ 'openssh-ldap' ],
  $user             = 'sshkeys',
  $uid              = '333',
  $gid              = '333',
  $tls_checkpeer    = 'yes',
  $tls_cacertfile   = '/etc/openldap/cacerts/cacert.pem',
  $uri              = undef,
  $base_dn          = undef,
  $bind_dn          = undef,
  $bind_pass        = undef,
  $ldap_conf        = undef,

) inherits openssh {

  if (
    (($::lsbdistid == 'RedHat') and ($::lsbdistrelease >= 6.4))
    or
    (($::lsbdistid == 'AmazonAMI') and ($::lsbdistrelease >= '2013.09'))
    ) {
      clabs::install { $packages:; }

      group {
        $user:
          ensure      => 'present',
          gid         => $gid,
          forcelocal  => true,
      }

      clabs::user {
        $user:
          comment     => 'OpenSSH LDAP Public Keys',
          ensure      => 'present',
          managehome  => false,
          uid         => $uid,
          gid         => $gid,
          shell       => '/sbin/nologin',
          password    => '*',
          system      => true,
          home        => '/etc/ssh',
          require     => Group[$user],
      }

      clabs::template { '/etc/ssh/ldap.conf':
        owner   => $user,
        group   => $user,
        mode    => '440',
        require => Clabs::User[$user],
        notify  => Service[$svc],
      }

  } else {
    clabs::module::unsupported { $name:
      msg => "OpenSSH LPK is not supported on this OS release."
    }
  }

}

