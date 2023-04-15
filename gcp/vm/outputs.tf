/* output "public_ip_1" {
  value = google_compute_instance.dvwa_instance_1.network_interface.0.access_config.0.nat_ip
}
output "public_ip_2" {
  value = google_compute_instance.dvwa_instance_2.network_interface.0.access_config.0.nat_ip
} */
output "instance_group" {
  value = google_compute_instance_group.dvwa-backend.id
}