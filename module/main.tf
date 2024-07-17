module "dev" {

source = "./ec2"
ami_id = var.ami_id
instance_type = var.instance_type
key_name = var.key_name

}