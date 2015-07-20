# Takes care of starting abrt service
class abrt::service {
  service { 'abrtd':
    ensure => running,
    enable => true,
  }
}
