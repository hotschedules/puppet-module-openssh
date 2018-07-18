# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class openssh(
  $enabled                          = true,
  $svc                              = 'sshd',
  $packages                         = [
    'openssh-server',
    'openssh-clients',
  ],
  $port                             = 22,
  $addressfamily                    = 'any',
  $syslogfacility                   = 'AUTHPRIV',
  $_loglevel                        = 'VERBOSE',
  $permitrootlogin                  = 'forced-commands-only',
  $passwordauthentication           = 'yes',
  $challengeresponseauthentication  = 'no',
  $usepam                           = 'yes',
  $kexalgorithms                    = undef,
  $sftp_ext_config                  = undef,
  $sftp_group                       = undef,
  $sftp_forcecommand                = undef,
  $sftp_chrootdir                   = undef,
  $allowgroups                      = [
    'ec2-user',
    'adm',
    "${::environment}_ssh_login",
  ],
  $pubkeyauthentication             = 'yes',
  $maxsessions                      = undef,
  $lpk                              = false,
  $usedns                           = 'yes',
  $authorizedkeyscommand            = '/usr/libexec/openssh/ssh-ldap-wrapper',
  $authorizedkeyscommanduser        = 'sshkeys',
) {

  if hiera("openssh::x11forwarding", undef) == undef {
    $x11forwarding = false
  } else {
    $x11forwarding = hiera("openssh::x11forwarding")
  }

  clabs::module::init { $name: }

  # LDAP Public Keys
  if $lpk {
    class { "::${name}::lpk": require => Class["::${name}::config"] }
    contain "${name}::lpk"
  }

}

