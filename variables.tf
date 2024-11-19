variable "rgname" {
    type    = string
    default = "rg1"
}

variable "rglocation" {
    type    = string
    default = "Central India"
}

variable "cosmosdbaccount" {
    type        = string
    default     = "strapi-cdb"
}

variable "cosmosdbdatabase" {
    type        = string
    default     = "strapi_cosmos_db_database"
}
variable "sqlcontainer" {
    type        = string
    default     = "strapi-container"
}

variable "admin_username" {
    type    = string
    default = "strapi"
}

variable "admin_password" {
    description = "Password for the PostgreSQL"
    type        = string
    sensitive   = true
}

variable "vnet" {
    type    = string
    default = "strapi-vnet"
}
    
variable "subnet" {
    type    = string
    default = "strapi-subnet"
}

variable "nic" {
    type    = string
    default = "strapi-nic"
}

variable "vm" {
    type    = string
    default = "strapi-vm"
}

variable "private_key_path" {
    type    = string
    default = "linuxkey.pem"
}

variable "public_key_path" {
    type    = string
    default = "linuxkey.pub"  
}

variable "storage_account" {
    type    = string
    default = "strapi-account345" 
}

variable "container" {
    type    = string
    default = "container" 
}

variable "nsg_vm" {
    type = string
    default = "strapi-nsg"
}