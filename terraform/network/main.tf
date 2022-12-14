resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = var.app_name
  }
}

resource "aws_subnet" "public_subnets" {
  count = length(var.public_subnet_cidrs)

  vpc_id = aws_vpc.vpc.id

  availability_zone       = var.azs[count.index]
  cidr_block              = var.public_subnet_cidrs[count.index]
  map_public_ip_on_launch = true # サブネット内で起動するEC2インスタンスに自動的にパブリックIPを割り当てる
  tags = {
    Name = "${var.app_name}-public-${var.azs_name[count.index]}"
  }
}

resource "aws_subnet" "private_subnets" {
  count = length(var.private_subnet_cidrs)

  vpc_id = aws_vpc.vpc.id

  availability_zone = var.azs[count.index]
  cidr_block        = var.private_subnet_cidrs[count.index]
  tags = {
    Name = "${var.app_name}-private-${var.azs_name[count.index]}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = var.app_name
  }
}

# パブリックサブネット用のルートテーブル
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-public-rtb"
  }
}

# パブリックサブネット用のルートテーブルの中身
resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id # VPC内部からの外部向けの通信をIGWへ向ける
  destination_cidr_block = "0.0.0.0/0"
}

# ルートテーブルとパブリックサブネットの紐づけ
resource "aws_route_table_association" "public" {
  count = length(var.public_subnet_cidrs)

  subnet_id      = element(aws_subnet.public_subnets.*.id, count.index)
  route_table_id = aws_route_table.public.id
}

# プライベートサブネット用のルートテーブル
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${var.app_name}-private-rtb"
  }
}

# ルートテーブルとプライベートサブネットの紐づけ
resource "aws_route_table_association" "private" {
  count = length(var.private_subnet_cidrs)

  subnet_id      = element(aws_subnet.private_subnets.*.id, count.index)
  route_table_id = aws_route_table.private.id
}
