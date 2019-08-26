# ==============================================================
# Variables Required to Create the Instance
# ==============================================================


variable "ami_id" {
 default = "default"
 description  = "The ami id to be used for creating the instance"
}

variable "instance_type" {
 default = "default"
 description  = "The type of instance to be used"
}

variable "subnet_id" {
description  = "The subnet to be used for associating with the instance"
}

variable "key_name" {
 default = "default"
}

variable "monitoring" {
 default = false
 description  = "Monitoring to be enabled or not for the instance"
}

variable "vpc_security_group_ids" {
description  = "The security groups to be associated with the instance"
}

variable "associate_public_ip_address" {
 default = false
 description  = "Condition for creating the instance with public ip address"
}

variable "instance_tagName" {
description  = "The environment type for the instance"
}



