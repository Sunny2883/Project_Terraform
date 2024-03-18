variable "cidr_block" {
  description = "cidr_block for Vpc"
  type = string
  default = "10.0.0.0/16"
}

variable "cidr_block_public_subnet" {
  type = list(string)
  description = "cidr block for public subnet"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}




variable "azs" {
 type        = list(string)
 description = "Availability Zones"
 default     =  ["ap-south-1a", "ap-south-1b"]

}