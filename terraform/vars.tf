variable "vm_size_master" {
  type = string
  description = "Tamaño de la máquina virtual Master"
  default = "Standard_D2_v2" # 4 GB, 2 CPU 
}

variable "vm_size_nfs" {
  type = string
  description = "Tamaño de la máquina virtual NFS"
  default = "Standard_A1_v2" # 4 GB, 2 CPU 
}

variable "vm_size_worker" {
  type = string
  description = "Tamaño de la máquina virtual Worker"
  default = "Standard_A2_v2" # 4 GB, 2 CPU 
}


variable "environment" {
  type = string
  description = "Nombre de la etiqueta environment"
  default = "UNIR_JMG_TP2" 
}

variable "prefix" {
  default       = "jmg"
  description = "The prefix which should be used for all resources in this plan"
}

variable "resource_grp" {
  type              = string  
  description       = "rg"
  default           = "TP2_RG"
}


variable "resource_prefix" {
  type        = string
  description = "prefix"
  default     = "jmg"
}

variable "vm_size" {
  type        = string
  description = "vm size"
  default     = "Standard_B2s"
}

variable "ssh_public_key" {
    default = "~/.ssh/id_rsa.pub"
}

variable "server_count" {
  type        = number
  description = "No of servers to be created"
  default = 1
}