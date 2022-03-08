variable "tenancy_ocid" {
  description = "Tenancy's OCID"
}

variable "user_ocid" {
  description = "User's OCID"
  default = ""
}

variable "compartment_ocid" {
  description = "Compartment's OCID where VCN will be created. "
}

variable "region" {
  description = "OCI Region"
}

variable "existing_vcn_ocid" {
  description = "OCID of an existing VCN to use"
  default     = ""
}

variable "existing_public_subnet_ocid" {
  description = "OCID of an existing public subnet to use"
  default     = ""
}

variable "existing_private_subnet_ocid" {
  description = "OCID of an existing private subnet to use"
  default     = ""
}

variable "existing_internet_gateway_ocid" {
  description = "OCID of an existing internet gateway to use"
  default     = ""
}

variable "existing_nat_gateway_ocid" {
  description = "OCID of an existing NAT gateway to use"
  default     = ""
}

variable "existing_public_route_table_ocid" {
  description = "OCID of an existing public route table to use"
  default     = ""
}

variable "existing_private_route_table_ocid" {
  description = "OCID of an existing private route table to use"
  default     = ""
}

variable "existing_public_security_list_ocid" {
  description = "OCID of an existing public security list (ssh) to use"
  default     = ""
}

variable "existing_public_security_list_http_ocid" {
  description = "OCID of an existing security list allowing https and https to use"
  default     = ""
}

variable "existing_private_security_list_ocid" {
  description = "OCID of an existing private security list allowing MySQL access to use"
  default     = ""
}

variable "existing_mds_instance_ocid" {
  description = "OCID of an existing MDS instance to use"
  default     = ""
}


variable "vcn" {
  description = "VCN Name"
  default     = "mysql_vcn"
}

variable "vcn_cidr" {
  description = "VCN's CIDR IP Block"
  default     = "10.0.0.0/16"
}

variable "fingerprint" {
  description = "Key Fingerprint"
  default     = ""
}

variable "dns_label" {
  description = "Allows assignment of DNS hostname when launching an Instance. "
  default     = ""
}

variable "node_image_id" {
  description = "The OCID of an image for a node instance to use. "
  default     = ""
}

variable "node_shape" {
  description = "Instance shape to use for master instance. "
  default     = "VM.Standard.E2.1"
}

variable "node_flex_shape_ocpus" {
  description = "Flex Instance shape OCPUs"
  default = 1
}

variable "node_flex_shape_memory" {
  description = "Flex Instance shape Memory (GB)"
  default = 6
}

variable "label_prefix" {
  description = "To create unique identifier for multiple setup in a compartment."
  default     = ""
}

variable "admin_password" {
  description = "Password for the admin user for MySQL Database Service"
}

variable "admin_username" {
  description = "MySQL Database Service Username"
  default = "admin"
}

variable "mosquitto_password" {
  description = "Password for the MQTT Broker"
  default = "PiD4y2022"
}

variable "mosquitto_username" {
  description = "MQTT Broker Username"
  default = "piday"
}

variable "ssh_authorized_keys_path" {
  description = "Public SSH keys path to be included in the ~/.ssh/authorized_keys file for the default user on the instance. DO NOT FILL WHEN USING REOSURCE MANAGER STACK!"
  default     = ""
}

variable "ssh_private_key_path" {
  description = "The private key path to access instance. DO NOT FILL WHEN USING RESOURCE MANAGER STACK!"
  default     = ""
}

variable "private_key_path" {
  description = "The private key path to pem. DO NOT FILL WHEN USING RESOURCE MANAGER STACK! "
  default     = ""
}

variable "mysql_shape" {
    default = "MySQL.HeatWave.VM.Standard.E3"
}


variable "mds_instance_name" {
  description = "Name of the MDS instance"
  default     = "MySQLInstance"
}

variable "iot_instance_name" {
  description = "Name of the IoT compute instance"
  default     = "IoTServer"
}

variable "deploy_mds_ha" {
  description = "Deploy High Availability for MDS"
  type        = bool
  default     = false
}

variable "use_mosquitto" {
  description = "Deploy Open Source MQTT v5/v3.1.x Broker Mosquitto instead of MysQL Router"
  type        = bool
  default     = false
}

variable "deploy_mds_heatwave" {
  description = "Deploy HeatWave Cluster"
  type        = bool
  default     = false
}

variable "heatwave_cluster_size" {
  description = "MySQL HeatWave Cluster Size"
  default     = 2
}
