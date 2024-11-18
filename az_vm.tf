resource "azurerm_virtual_network" "vnet" {
    name                = "strapi-vnet"
    address_space       = ["10.0.0.0/16"]
    location            = var.rglocation
    resource_group_name = var.rgname
}

resource "azurerm_subnet" "subnetB" {
    name                 = "strapi-subnet"
    resource_group_name  = var.rgname
    virtual_network_name = var.vnet
    address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_network_security_group" "nsg" {
    name                = "strapi-nsg"
    location            = var.rglocation
    resource_group_name = var.rgname

    security_rule {
        name                       = "AllowSSH"
        priority                   = 1000
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = 22
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
}

resource "azurerm_subnet_network_security_group_association" "sec-group-association2" {
    subnet_id                 = azurerm_subnet.subnetB.id
    network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_public_ip" "public_ip" {
    name                = "strapi-public-ip"
    location            = var.rglocation
    resource_group_name = var.rgname
    allocation_method   = "Static"
}

resource "azurerm_network_interface" "net-int" {
    name                        = "strapi-nic"
    location                    = var.rglocation
    resource_group_name         = var.rgname
    ip_configuration {
        name                          = "ip-config"
        subnet_id                     = azurerm_subnet.subnetA.id
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.public_ip.id
    }

    depends_on = [
        azurerm_virtual_network.vnet,
        azurerm_public_ip.public_ip,
        azurerm_subnet_network_security_group_association.sec-group-association2
    ]
}

resource "tls_private_key" "linux_key" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "local_file" "linuxkey" {
    content  = tls_private_key.linux_key.private_key_pem
    filename = var.private_key_path
}

resource "local_file" "linuxkey_pub" {
    content        = tls_private_key.linux_key.public_key_openssh
    filename       = var.public_key_path
    file_permission = "0644"
}

resource "azurerm_linux_virtual_machine" "vm" {
    name                    = "strapi-vm"
    resource_group_name     = var.rgname
    location                = var.rglocation
    size                    = "Standard_F2"
    admin_username          = var.admin_username
    network_interface_ids   = [
        azurerm_network_interface.net-int.id
    ]

    admin_ssh_key {
        username   = var.admin_username
        public_key = tls_private_key.linux_key.public_key_openssh
    }

    os_disk {
        caching              = "ReadWrite"
        storage_account_type = "Standard_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "0001-com-ubuntu-server-jammy"
        sku       = "22_04-lts"
        version   = "latest"
    }

    depends_on = [
        tls_private_key.linux_key,
        azurerm_public_ip.public_ip
    ]
}

resource "null_resource" "instance_details" {
  provisioner "local-exec" {
    command = <<EOF
      echo '{
        "instance_id": "${azurerm_linux_virtual_machine.vm.id}",
        "public_ip": "${azurerm_public_ip.public_ip.ip_address}"
      }' > ./output/vm-details.json
    EOF
  }
}
