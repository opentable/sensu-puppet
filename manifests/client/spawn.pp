# = Class: sensu::client::spawn
#
# Sets the Sensu process spawn config
#
class sensu::client::spawn {

  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  if ($sensu::_purge_config and !$sensu::client) or !$sensu::client_spawn_limit {
    $ensure = 'absent'
  } else {
    $ensure = 'present'
  }

  if $sensu::client_spawn_limit {
    file { "${sensu::conf_dir}/spawn.json":
      ensure  => $ensure,
      owner   => $sensu::user,
      group   => $sensu::group,
      mode    => $sensu::file_mode,
      content => template("${module_name}/sensu-client-spawn.erb")
    }
  }

}
