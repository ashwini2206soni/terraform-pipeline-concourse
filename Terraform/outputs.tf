output "ip_address" {
  value = network_interface.0.access_config.0.nat_ip
}
