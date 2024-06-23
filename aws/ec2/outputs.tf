output "ssh" {
  value = "ssh -i keys/id_rsa -p 22 ubuntu@${aws_instance.tpot.public_ip}"
}
