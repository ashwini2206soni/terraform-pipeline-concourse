output "ip_address" {
  value = google_compute_instance.docker.0.network_interface.0.access_config.0.nat_ip
}

