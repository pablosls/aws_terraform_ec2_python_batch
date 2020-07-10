resource "aws_vpc" "main" {
  cidr_block           = var.vpcCIDRblock
  instance_tenancy     = var.instanceTenancy
  enable_dns_support   = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    Name = "VPC teste"
  }
}
resource "aws_subnet" "Public_subnet" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.publicsCIDRblock
  map_public_ip_on_launch = var.mapPublicIP
  availability_zone       = var.availabilityZone
  tags = {
    Name = "Public subnet"
  }
}

resource "aws_security_group" "sg_do_pablo" {
    
    name        = "sg_pablinho"

    tags        = {}
    vpc_id      = aws_vpc.main.id

    egress      = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 0
            ipv6_cidr_blocks = []
            prefix_list_ids  = []
            protocol         = "-1"
            security_groups  = []
            self             = false
            to_port          = 0
        },
    ]

    ingress     = [
        {
            cidr_blocks      = [
                "0.0.0.0/0",
            ]
            description      = ""
            from_port        = 80
            ipv6_cidr_blocks = [
                "::/0",
            ]
            prefix_list_ids  = []
            protocol         = "tcp"
            security_groups  = []
            self             = false
            to_port          = 80
        },
    ]


}

resource "aws_internet_gateway" "IGW_teste" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Internet gateway teste"
  }
}
resource "aws_route_table" "Public_RT" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "Public Route table"
  }
}
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.Public_RT.id
  destination_cidr_block = var.publicdestCIDRblock
  gateway_id             = aws_internet_gateway.IGW_teste.id
}
resource "aws_route_table_association" "Public_association" {
  subnet_id      = aws_subnet.Public_subnet.id
  route_table_id = aws_route_table.Public_RT.id
}