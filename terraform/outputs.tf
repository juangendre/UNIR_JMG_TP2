output master_public_ip {
  value       = azurerm_linux_virtual_machine.vmMaster.public_ip_address
}

output worker1_public_ip {
  value       = azurerm_linux_virtual_machine.vmWorker1.public_ip_address
}


#output worker2_public_ip {
#  value       = azurerm_linux_virtual_machine.vmWorker2.public_ip_address
#}

output nfs_public_ip {
  value        = azurerm_linux_virtual_machine.vmNfs.public_ip_address
}
