variable "ami" {
    description = "passing ami to main.tf"
    type = string
    default = ""
  
}

variable "instance_type" {
    description = "passing to inst to main.tf"
    type = string
    default = ""
  
}

variable "key_name" {
    description = "passing key to main.tf"
    type = string
    default = ""

  
}