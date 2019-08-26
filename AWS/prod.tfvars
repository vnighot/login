
# =================================================================================
# Variables Required to Create the PROD Environment infrastructure.
# =================================================================================


vpc_tagName = "prod"
vpc_cidrBlock = "11.0.0.0/16"
environment = "prod"
department = "PSG"
organization = "Tibco"
subnet_cidrBlock = "11.0.1.0/24"
subnet_tagName = "subnet"
sg_name         = "SSH"
sg_description  = "Allow SSH to machine"
sg_ingressCIDRblock = "0.0.0.0/0"  
sg_fromPort   = 22
sg_toPort     = 22
sg_protocol    = "tcp"
sg_tagName = "ssh_sg"
ig_tagName = "ig_prod"
rt_cidrBlock = "0.0.0.0/0"
rt_tagName = "rt_prod"
ami_id = "ami-0ebbf2179e615c338"
instance_type = "t2.micro"
key_name = "Test"
monitoring = false
associate_public_ip_address = true
instance_tagName = "Application Server"
