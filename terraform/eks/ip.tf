
data "http" "ip" {
  url = "https://ipv4.icanhazip.com/"
}

locals {
  my_public_ip  = chomp(data.http.ip.response_body)
  my_cidr_block = "${local.my_public_ip}/32"
}
