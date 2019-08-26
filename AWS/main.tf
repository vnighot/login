#############################################################################
#  
#   README
#   ====== 
# * This is a Instance module.
#
#############################################################################

# ==============================================================
# Create your Instance on AWS
# ==============================================================


resource "aws_instance" "main" {

  ami                    = "${var.ami_id}"
  instance_type          = "${var.instance_type}"
  subnet_id              = "${var.subnet_id}"
  key_name               = "${var.key_name}"
  monitoring             = "${var.monitoring}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  associate_public_ip_address = "${var.associate_public_ip_address}"

  tags {
    Name = "${var.instance_tagName}"
    Environment = "${var.environment}"
    Department = "${var.department}"
    Organization = "${var.organization}"
  }
} # end resource
