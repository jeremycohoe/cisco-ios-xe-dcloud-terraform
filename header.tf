terraform {
  required_providers {
    iosxe = {
      source  = "CiscoDevNet/iosxe"
      version = ">= 0.5.1"
    }
  }
}

provider "iosxe" {
  username = "developer"
  password = "C1sco12345"
  url      = "https://198.18.1.21"
}

variable source_address {
    type = string
    default = "1.1.1.1"
    description = "Source address" 
}

variable receiver_ip {
    type = string
    default = "1.1.1.1"
    description = "Receiver IP" 
}

variable receiver_port  {
    type = string
    default = "57500"
    description = "Port to send data to" 
}