resource "aws_instance" "Philip" {
    ami = var.ami.id
    instance_type = var.instance_type
    key_name = var.key_name
    tags = {
      Name = "Philip"
    }
  
}