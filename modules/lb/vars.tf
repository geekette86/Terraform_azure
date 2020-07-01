variable "frontend_name" {
  description = "Specifies the name of the frontend ip configuration"
  default = "MyLBFrontEnd"
}

variable private_ip_address {
  type        = "string"
  description = "The address prefix to use for the subnet."
  default     = "10.2.0.12"
}


variable private_ip_address_allocation {
    type        = "string"
  description = "static or dynamic."
  default     = "static"
}
variable probe_params {
  default = ["MyLBProbe","http","80","/","10","3"]
  description = "List containing LB probe parameters: name, protocol, port, request path, interval in seconds and number of probes"
}

variable rule_params {
  default = ["MyLBRule","tcp","80","80","false","5"]
  description = "List containing LB rule parameters: name, protocol, frontend port, backend port, enable floating IP and idle time in minutes"
}

variable nat_pool_params {
  default = ["3", "MyLBNatPool","tcp","50000","50100","22"]
  description = "List containing LB rule parameters: count, name, protocol, frontend port start, frontend port end, backend port"
}

variable "vm_name" {
    type = "string"
    default = "Nova-dev-Dk-BA"
  }
 variable "vm_count" {
    default  = 1
  }
  variable sshkey {
  default = ""
  description = "Public key used"
}
 variable "location" {
    type     = "string"
  }

  variable "rg_tag" {
     type = "map" 
    default = {
        dev = "dev"
    }
  }

  variable "rg_name" {
    type    = "string"
    default = "manel"
  }
  variable "subnet_id" {
    type    = "string"
    default = "main"
  }