## DATASOURCE
# Init Script Files


locals {
  shell_script          = "~/install_shell.sh"
  mosquitto_script      = "~/install_mosquitto.sh"
  router_script         = "~/install_router.sh"
  deploy_script         = var.use_mosquitto == false ? local.router_script : local.mosquitto_script
  security_script       = "~/configure_local_security.sh"
  fault_domains_per_ad = 3
}

data "template_file" "install_shell" {
  template = file("${path.module}/scripts/install_shell.sh")

  vars = {
    mysql_version         = var.mysql_version,
    user                  = var.vm_user
  }
}

data "template_file" "install_mosquitto" {
  template = file("${path.module}/scripts/install_mosquitto.sh")
  vars = {
    mosquitto_password    = var.mosquitto_password,
    mosquitto_username    = var.mosquitto_username
  }
}


data "template_file" "install_router" {
  template = file("${path.module}/scripts/install_router.sh")
  vars = {
    mds_ip                = var.mds_ip,
    user                  = var.vm_user
  }
}

data "template_file" "configure_local_security" {
  template = file("${path.module}/scripts/configure_local_security.sh")
}

resource "oci_core_instance" "IoT" {
  compartment_id      = var.compartment_ocid
  display_name        = "${var.label_prefix}${var.display_name}"
  shape               = var.shape
  availability_domain = var.availability_domains[0]

  dynamic "shape_config" {
    for_each = local.is_flexible_node_shape ? [1] : []
    content {
      memory_in_gbs = var.flex_shape_memory
      ocpus = var.flex_shape_ocpus
    }
  }


  create_vnic_details {
    subnet_id        = var.subnet_id
    display_name     = "${var.label_prefix}${var.display_name}"
    assign_public_ip = var.assign_public_ip
    hostname_label   = "${var.display_name}"
  }

  metadata = {
    ssh_authorized_keys = var.ssh_authorized_keys
  }

  source_details {
    source_id   = var.image_id
    source_type = "image"
  }


  provisioner "file" {
    content     = data.template_file.install_router.rendered
    destination = local.router_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }
  }

  provisioner "file" {
    content     = data.template_file.install_mosquitto.rendered
    destination = local.mosquitto_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }
  }

  provisioner "file" {
    content     = data.template_file.configure_local_security.rendered
    destination = local.security_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }
  }

  provisioner "file" {
    content     = data.template_file.install_shell.rendered
    destination = local.shell_script

    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }
  }

   provisioner "remote-exec" {
    connection  {
      type        = "ssh"
      host        = self.public_ip
      agent       = false
      timeout     = "5m"
      user        = var.vm_user
      private_key = var.ssh_private_key

    }

    inline = [
       "chmod +x ${local.shell_script}",
       "sudo ${local.shell_script}",
       "chmod +x ${local.deploy_script}",
       "sudo ${local.deploy_script}",
       "chmod +x ${local.security_script}",
       "sudo ${local.security_script}"
    ]

   }

  timeouts {
    create = "10m"

  }
}
