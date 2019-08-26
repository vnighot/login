variable "name" {
  type        = "string"
  default 	  = "testdomain.com"
  description = "Name of the hosted zone"
}

variable "product_domain" {
  type        = "string"
  default 	  = "tibco products"
  description = "Abbreviation of the product domain this Route 53 zone belongs to"
}

variable "environment" {
  type        = "string"
  default	  = "Test"
  description = "Environment this Route 53 zone belongs to"
}

variable "force_destroy" {
  type        = "string"
  default     = false
  description = "Whether to destroy all records inside if the hosted zone is deleted"
}