variable "resource_names" {
  description = "Map of known resource names"
  type        = map(string)

  default = {
    # VPC Name
    vpc_name = "VPC"

    # Neptune Subnet
    neptune_subnet_name = "NTST-AZ"

    # Public Subnet
    public_subnet_name = "PBST-AZ"

    # Public Route table
    pubic_rt_name = "PUB-RT"

    # Public Route table
    private_rt_name = "PVT-RT"

    # NAT Gateway
    nat_gateway_name = "NAT-AZ"

    # Internet Gateway
    igw_name = "IGW"

    # NAT EIP
    nat_eip_name = "NAT-EIP"
  }
}
