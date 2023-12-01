resource "iosxe_mdt_subscription" "cpu_subs" {
  for_each               = var.cpu_subscriptions
  subscription_id        = each.key
  stream                 = "yang-push"
  encoding               = "encode-kvgpb"
  source_vrf             = "Mgmt-vrf"
  update_policy_periodic = var.cpu_periodic
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

variable cpu_periodic {
    type = string
    default = "100"
    description = "Short update interval" 
}

#CPU.tf
variable "cpu_subscriptions" {
  default = {
    100 = {
      xpath = "/process-cpu-ios-xe-oper:cpu-usage/cpu-utilization/five-seconds"
    },
    101 = {
      xpath = "/process-cpu-ios-xe-oper:cpu-usage/cpu-utilization/one-minute"
    },
    102 = {
      xpath = "/process-cpu-ios-xe-oper:cpu-usage/cpu-utilization/five-minutes"
    }
  }
}

