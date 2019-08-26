########################################################################################
#  #   README
#   ====== 
# * Pre-Requisite
#   1) Install Terraform
#
# * Stand Up Steps
#   1) Update the variables in prod.tfvars 
#   2) Run "terraform get"
#   3) Run "terraform init -var-file="prod.tfvars""
#	4) Run "terraform apply -var-file="prod.tfvars""
#
# * (optional) Tear Down Steps
#   1) Run "terraform destroy"
########################################################################################

# ======================================================================================
# Creating infra for Prod Env.
# ======================================================================================


provider "aws" {
  access_key = "AKIASSEWCRZU7B7KPLPC"
  secret_key = "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"
  region     = "us-east-2"
   assume_role {
   role_arn     = "arn:aws:iam::604264435888:role/TIBCO/Administrator"
 }
}


# ======================================================================================
# Variables Required to create the infra.
# ======================================================================================


variable "vpc_tagName" {}

variable "vpc_cidrBlock" {}

variable "environment" {}

variable "department" {}

variable "organization" {}

variable "subnet_cidrBlock" {}

variable "subnet_tagName" {}

variable "sg_name" {}

variable "sg_description" {}

variable "sg_ingressCIDRblock" {} 

variable "sg_fromPort" {}

variable "sg_toPort" {}

variable "sg_protocol" {}

variable "sg_tagName" {}

variable "ig_tagName" {}

variable "rt_cidrBlock" {}

variable "rt_tagName" {}
  
variable "ami_id" {}

variable "instance_type" {}

variable "key_name" {}

variable "monitoring" {}

variable "associate_public_ip_address" {}

variable "instance_tagName" {}




# =======================================================================================
# Calling Various Modules.
# ==============================================================

module "vpc_prod" {
  source = "../../modules/AWS/modules/networking/vpc"
  vpc_cidrBlock = "${var.vpc_cidrBlock}"
  vpc_tagName = "${var.vpc_tagName}"
  environment = "${var.environment}"
  department = "${var.department}"
  organization = "${var.organization}"
}


module "subnet_prod" {
  source = "../../modules/AWS/modules/networking/subnet"
  subnet_cidrBlock = "${var.subnet_cidrBlock}"
  subnet_tagName = "${var.subnet_tagName}"
  subnet_vpcId = "${module.vpc_prod.vpc_id}"
  environment = "${var.environment}"
  department = "${var.department}"
  organization = "${var.organization}"
}

module "internet_gateway"  {
  source = "../../modules/AWS/modules/networking/internetGateway"
  ig_vpcId = "${module.vpc_prod.vpc_id}"
  ig_tagName = "${var.ig_tagName}"
  environment = "${var.environment}"
  department = "${var.department}"
  organization = "${var.organization}"
}

module "route_table" {
  source = "../../modules/AWS/modules/networking/routeTable"
  rt_vpcId = "${module.vpc_prod.vpc_id}"
  rt_cidrBlock = "${var.rt_cidrBlock}"
  rt_gatewayId = "${module.internet_gateway.ig_id}"
  rt_tagName = "${var.rt_tagName}"
  environment = "${var.environment}"
  department = "${var.department}"
  organization = "${var.organization}"
}


module "securityGroup_prod" {
  source = "../../modules/AWS/modules/networking/securityGroups"
  sg_vpcId       = "${module.vpc_prod.vpc_id}"
  sg_name         = "${var.sg_name}"
  sg_description  = "${var.sg_description}"
  sg_ingressCIDRblock = "${var.sg_ingressCIDRblock}"  
  sg_fromPort   = "${var.sg_fromPort}"
  sg_toPort     = "${var.sg_toPort}"
  sg_protocol    = "${var.sg_protocol}"
  sg_tagName = "${var.sg_tagName}"
  environment = "${var.environment}"
  department = "${var.department}"
  organization = "${var.organization}"
}



module "route_table_association" {
  source = "../../modules/AWS/modules/networking/routeTableAssociation"
  subnet_id      = "${module.subnet_prod.subnet_id}"
  rt_id          = "${module.route_table.rt_id}"
} 


module "instance_create" {
  source = "../../modules/AWS/modules/instance"
  ami_id 				 = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${module.subnet_prod.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = "${module.securityGroup_prod.sg_id}"
  associate_public_ip_address = "${var.associate_public_ip_address}"
  instance_tagName = "${var.instance_tagName}"
  environment = "${var.environment}"
  department = "${var.department}"
  organization = "${var.organization}"
}


