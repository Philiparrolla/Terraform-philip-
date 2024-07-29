resource "aws_vpc" "Philip" {
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "Philip"
    }
  
}

resource "aws_internet_gateway" "IG" {
    vpc_id = aws_vpc.Philip.id
    tags = {
      Name = "IG"
    }
  
}

resource "aws_subnet" "subnet" {
    cidr_block = "10.0.0.0/22"
    vpc_id = aws_vpc.Philip.id
    availability_zone = "ap-south-1a"
    tags = {
      Name = "subnet-1"
    }
    
  
}

resource "aws_route_table" "route" {
  vpc_id = aws_vpc.Philip.id
  tags = {
    Name = "route"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.IG.id
  }
}

resource "aws_route_table_association" "Philip" {
  subnet_id = aws_subnet.subnet.id
  route_table_id = aws_route_table.route.id
  
}



resource "aws_nat_gateway" "my-nat" {
  connectivity_type = "public"
  allocation_id = aws_eip.Philip.id
  subnet_id = aws_subnet.subnet.id
  tags = {
    Name = "my-nat"
  }
  
}
resource "aws_eip" "Philip" {
  domain = "vpc"
  
}

resource "aws_subnet" "subnet-2" {
  vpc_id = aws_vpc.Philip.id
  availability_zone = "ap-south-1b"
  cidr_block = "10.0.32.0/26"
  tags = {
    Name = "subnet-2"
  }
  
}

resource "aws_route_table" "route-2" {
  vpc_id = aws_vpc.Philip.id
  tags = {
    Name = "route-2"
  }

 route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.my-nat.id
 }

}

resource "aws_security_group" "my-sg" {
    name = "allow_tls"
    vpc_id = aws_vpc.Philip.id
    tags = {
      Name = "cus-sg"


    }
   ingress {
    description = "tls from vpc"
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
   } 
  ingress {
    description = "tls from vpc"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
 ingress {
    description = "tls from vpc"
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
 }  

 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
     }
  
}

resource "aws_nat_gateway" "nat" {
  connectivity_type = "public"
  allocation_id = aws_eip.Prakesh.id
  subnet_id = aws_subnet.subnet.id
  tags = {
    Name = "my-nat"
  }
  
}
resource "aws_eip" "Prakesh" {
  domain = "vpc"
  
}

resource "aws_subnet" "subn" {
  vpc_id = aws_vpc.Philip.id
  cidr_block = "10.0.64.0/18"
  tags = {
    Name = "sub"
  }
  
}

resource "aws_route_table" "rou" {
  vpc_id = aws_vpc.Philip.id
  tags = {
    Name = "kk"
  }

 route {
  cidr_block = "0.0.0.0/0"
  nat_gateway_id = aws_nat_gateway.nat.id
 }

}

resource "aws_instance" "Tejamma" {
  ami = "ami-0d473344347276854"
  availability_zone = "ap-south-1a"
  instance_type = "t2.micro"
  key_name = "mykeyshh"
  subnet_id = aws_subnet.subnet.id
  security_groups = [aws_security_group.my-sg.id]
  associate_public_ip_address = true
  tags = {
    Name = "Tejamma-pub"
      }
  
}

resource "aws_instance" "Teja" {
  ami =   "ami-0d473344347276854"
  instance_type = "t2.micro"
  availability_zone = "ap-south-1b"
  key_name = "mykeyshh"
  subnet_id = aws_subnet.subnet-2.id
  security_groups = [aws_security_group.my-sg.id]
  tags = {
    Name = "Tejamma.pvt"
  }
  }

