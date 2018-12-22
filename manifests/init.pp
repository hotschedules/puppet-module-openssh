# vim: tabstop=2 expandtab shiftwidth=2 softtabstop=2 foldmethod=marker

class openssh(
  $enabled                          = true,
  $svc                              = 'sshd',
  $packages                         = [
    'openssh-server',
    'openssh-clients',
  ],
) {

  $sshd_config = hiera_hash('openssh::sshd_config',{})
  $ldap_conf = hiera_hash('openssh::ldap_conf',undef)

  clabs::module::init { $name: }

  # LDAP Public Keys
  unless $ldap_conf == undef {
    class { "::${name}::lpk": require => Class["::${name}::config"] }
    contain "${name}::lpk"
  }

}

