# Aviatrix Egress Spoke Gateway in AWS
resource "aviatrix_spoke_gateway" "dev_gateway_aws" {
  cloud_type        = 1
  account_name      = "${aviatrix_account.account_2.account_name}"
  gw_name           = "egress-gw"
  vpc_id            = "${module.development-vpc.vpc_id}"
  vpc_reg           = "us-east-1"
  gw_size           = "t2.micro"
  subnet            = "10.150.101.0/24"
  single_ip_snat    = false
  manage_ha_gateway = false
  #allocate_new_eip  = false
  #eip               = "x.y.z.a"
  tags              = {
    name = "value"
  }
}

#Aviatrix Secondary Gateway - deployed in Active-Active Mode
resource "aviatrix_spoke_ha_gateway" "test_spoke_ha_aws" {
  primary_gw_name = aviatrix_spoke_gateway.dev_gateway_aws.id
  subnet          = "10.150.102.0/24"
  #eip             = "x.y.z.b"
}

/*
#Egress FQDN Filtering Configuration and Ruleset Resource
resource "aviatrix_fqdn" "test_fqdn" {
  fqdn_tag     = "development_vpc_tag"
  fqdn_enabled = true
  fqdn_mode    = "white"
  gw_filter_tag_list {
    gw_name        = "egress-gw"
    source_ip_list = [
      "10.150.0.0/16"
    ]
  }
}

#Egress FQDN Filtering Rule (that attaches to Ruleset)
resource "aviatrix_fqdn_tag_rule" "test_fqdn" {
  fqdn_tag_name = "development_vpc_tag"
  fqdn          = "reddit.com"
  protocol      = "tcp"
  port          = "443"
}
*/