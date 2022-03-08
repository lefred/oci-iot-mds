output "id" {
  value = oci_core_instance.IoT.*.id
}

output "public_ip" {
  value = join(", ", oci_core_instance.IoT.*.public_ip)
}

