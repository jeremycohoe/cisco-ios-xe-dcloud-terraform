resource "iosxe_mdt_subscription" "example" {
  for_each               = var.subscriptions
  subscription_id        = each.key
  stream                 = "yang-push"
  encoding               = "encode-kvgpb"
  source_vrf             = "Mgmt-vrf"
  update_policy_periodic = var.example_periodic
  source_address         = var.source_address
  filter_xpath           = each.value.xpath
  receivers = [
    {
      address  = var.receiver_ip
      port     = var.receiver_port
      protocol = "grpc-tcp"
    }
  ]
 }

variable example_periodic {
    type = string
    default = "6000"
    description = "Long update interval" 
}

#XPATH.tf
variable "subscriptions" {
  default = {
    103 = {
      xpath = "/environment-ios-xe-oper:environment-sensors"
    },
    104 = {
      xpath = "/interfaces-ios-xe-oper:interfaces"

    }
  }
}