data "aws_subnet" "Philip" {
    id = "subnet-084c6cbd96369b8c9"
  
}

resource "aws_instance" "Philip" {
    ami = "ami-0d1e92463a5acf79d"
    instance_type = "t2.micro"
    key_name = "mykeyshh"
    subnet_id = data.aws_subnet.Philip.id
    tags = {
      Name = "philip"
    }
  
}