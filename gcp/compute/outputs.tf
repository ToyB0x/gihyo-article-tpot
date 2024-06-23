output "ssh" {
  value = "ssh -i keys/id_rsa -p 22 ubuntu@${google_compute_instance.tpot.network_interface.0.access_config.0.nat_ip}"
}
