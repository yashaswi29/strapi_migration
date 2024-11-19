resource "null_resource" "save_output_and_deploy" {

  depends_on = [
    azurerm_cosmosdb_sql_database.strapi_cosmos_db_database,  
    azurerm_linux_virtual_machine.vm,
    azurerm_storage_account.strapi_account345
  ]

  connection {
    type        = "ssh"
    host        = azurerm_linux_virtual_machine.vm.public_ip_address
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    timeout     = "8m"
  }

  provisioner "file" {
    source      = "/home/yashaswi/Developer/strapi_migration/scripts"
    destination = "/home/ubuntu/.scripts"
  }

  # provisioner "file" {
  #   source      = "./config"
  #   destination = "/home/ubuntu/.config"
  # }


  provisioner "remote-exec" {
    inline = [
      "/home/yashaswi/Developer/strapi_migration/scripts/nodeSetup.sh",
      "/home/yashaswi/Developer/strapi_migration/scripts/deployStrapi.sh",
      "/home/yashaswi/Developer/strapi_migration/scripts/nginxSetup.sh"
    ]
  }
}

resource "null_resource" "delete_output" {

  provisioner "local-exec" {
    when    = destroy
    command = "echo {} > ./output/vm-details.json && echo {} > ./output/db-details.json && echo {} > ./output/storage-details.json"
  }
}
