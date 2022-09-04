resource "aws_vpc" "main" {
  cidr_block = "100.0.0.0/16"

  tags = {
    Name = "doboku-post"
  }
}
