output "nic_1" {
  value = google_compute_subnetwork.subnet_1.id
}

output "nic_2" {
  value = google_compute_subnetwork.subnet_2.id
}

output "network" {
  value = google_compute_network.network.id
}

output "public_ip" {
  value = google_compute_global_address.default.address
}