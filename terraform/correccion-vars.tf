variable "location" {
  type              = string  
  description       = "location of rg"
  default           = "eastus"
}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "jmgstacctp2unir" 
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" # o la ruta correspondiente
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "juangendre"
}

