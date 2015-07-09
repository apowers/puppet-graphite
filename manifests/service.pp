# == Class: graphite::service
#
# Class to start carbon-cache and graphite-web processes
#
class graphite::service {
  $aggregator_ensure = $::graphite::carbon_aggregator ? {
    true    => running,
    default => stopped,
  }

  service { 'carbon-aggregator':
    ensure     => $aggregator_ensure,
    enable     => $::graphite::carbon_aggregator,
    hasstatus  => true,
    hasrestart => false,
#    provider   => upstart,
  } ->
  service { 'carbon-cache':
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => false,
#    provider   => upstart,
  }

#  service { 'graphite-web':
#    ensure     => running,
#    name       => 'httpd',
#    enable     => true,
#    hasstatus  => true,
#    hasrestart => false,
#    provider   => upstart,
#  }
}
