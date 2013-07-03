class graphite::config {

  $admin_password = $::graphite::admin_password
  $port = $::graphite::port
  $root_dir = $::graphite::root_dir

  file {
  [
    '/etc/init.d/carbon-cache',
    '/etc/init.d/graphite-web'
  ]:
    ensure => link,
    target => '/lib/init/upstart-job',
  }

  file { '/etc/init/carbon-cache.conf':
    ensure  => present,
    content => template('graphite/upstart/carbon-cache.conf'),
    mode    => '0555',
  }

  file { '/etc/init/graphite-web.conf':
    ensure  => present,
    content => template('graphite/upstart/graphite-web.conf'),
    mode    => '0555',
  }

  file { "${root_dir}/conf/carbon.conf":
    ensure    => present,
    content   => template('graphite/carbon.conf'),
  }

  file { "${root_dir}/conf/storage-schemas.conf":
    ensure    => present,
    source    => 'puppet:///modules/graphite/storage-schemas.conf',
  }

  file { ["${root_dir}/storage", "${root_dir}/storage/whisper"]:
    owner => 'www-data',
    mode  => '0775',
  }

  exec { 'init-db':
    command   => "/usr/bin/python manage.py syncdb --noinput",
    cwd       => "${root_dir}/webapp/graphite",
    creates   => "${root_dir}/storage/graphite.db",
    subscribe => File["${root_dir}/storage"],
    require   => File["${root_dir}/webapp/graphite/initial_data.json"],
  }

  file { "${root_dir}/webapp/graphite/initial_data.json":
    ensure  => present,
    require => File["${root_dir}/storage"],
    content => template('graphite/initial_data.json'),
  }

  file { "${root_dir}/storage/graphite.db":
    owner     => 'www-data',
    mode      => '0664',
    subscribe => Exec['init-db'],
  }

  file { "${root_dir}/storage/log/webapp/":
    ensure    => 'directory',
    owner     => 'www-data',
    mode      => '0775',
    subscribe => Exec['graphite/install graphite-web'],
  }

  file { "${root_dir}/webapp/graphite/local_settings.py":
    ensure  => present,
    source  => 'puppet:///modules/graphite/local_settings.py',
    require => File["${root_dir}/storage"]
  }

}