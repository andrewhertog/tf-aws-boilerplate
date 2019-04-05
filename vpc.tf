resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr_block}"
    tags {
        Name = "${var.vpc_name}"
    }
}

data "aws_availability_zones" "available"{}

resource "aws_subnet" "public_subnet" {
    count = "${var.num_public_subnets}"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index)}"
    map_public_ip_on_launch = true
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

    tags {
        Name = "${var.vpc_name}-public-${element(split("-", data.aws_availability_zones.available.names[count.index]),2)}"
    }
}

resource "aws_subnet" "private_subnet" {
    count = "${var.num_private_subnets}"
    vpc_id = "${aws_vpc.vpc.id}"
    cidr_block = "${cidrsubnet(aws_vpc.vpc.cidr_block, 8, count.index+24)}"
    map_public_ip_on_launch = false
    availability_zone = "${data.aws_availability_zones.available.names[count.index]}"

    tags {
        Name = "${var.vpc_name}-private-${element(split("-", data.aws_availability_zones.available.names[count.index]),2)}"
    }
}

