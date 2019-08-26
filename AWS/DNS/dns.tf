# This configures aws – required in all terraform files
provider "aws" {
  access_key = ""
  secret_key = ""
  region     = "us-east-2"
   assume_role {
   role_arn     = ""
 }
}

resource "aws_vpc" "primary" {
  cidr_block           = "10.6.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

resource "aws_vpc" "secondary" {
  cidr_block           = "10.7.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
}

locals {
  description = "Private zone for ${var.name}"
}

resource "aws_route53_zone" "main" {
  name          = "${var.name}"
  vpc {
    vpc_id = "${aws_vpc.primary.id}"
  }
  comment       = "${local.description}"
  force_destroy = "${var.force_destroy}"

  tags = {
    "Name"          = "${var.name}"
    "ProductDomain" = "${var.product_domain}"
    "Environment"   = "${var.environment}"
    "Description"   = "${local.description}"
  }
}

resource "aws_route53_zone_association" "secondary" {
  zone_id = "${aws_route53_zone.main.zone_id}"
  vpc_id  = "${aws_vpc.secondary.id}"
}