
variable "rgname" {
    type    = string
    default = "rg"
}

variable "rglocation" {
    type    = string
    default = "Central India"
}

variable "cosmosdbaccountname" {
    type    = string
    default = "strapi-cdb"
}

#Create a file called terraform.tfvars (or any other file with the extension .tfvars), and add the password there: [admin_password = "password"]
variable "admin_password" {
  description = "Password for the PostgreSQL administrator."
  type        = string
  sensitive   = true
}

