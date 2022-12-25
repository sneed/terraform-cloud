region = "us-east-1"

vpc_cidr = "10.0.0.0/16"

enable_dns_support = "true"

enable_dns_hostnames = "true"

enable_classiclink = "false"

enable_classiclink_dns_support = "false"

preferred_number_of_public_subnets = 2

preferred_number_of_private_subnets = 4

environment = "dev"

ami = "ami-0a6b2839d44d781b2"

keypair = "IML-keypair"

# Ensure to this change to your account number
account_no = "218277270766"

master-password = "tommy12345"
master-username = "tommy"


tags = {
  Environment     = "production"
  Owner-Email     = "bo_aduroja@yahoo.co.uk"
  Managed-By      = "Terraform"
  Billing-Account = "218277270766"
}
