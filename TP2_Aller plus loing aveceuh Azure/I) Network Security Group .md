## I. Network Security Group

### 2. Ajouter un NSG au déploiement

#### 🌞 Ajouter un NSG à votre déploiement Terraform

    resource "azurerm_network_security_group" "main" {
      name                = "vm-nsg"
      location            = var.location
      resource_group_name = var.resource_group_name
    
      security_rule {
        name                       = "allow_ssh_from_my_ip"
        priority                   = 100
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "${data.http.my_ip.response_body}/32"
        destination_address_prefix = "*"
      }


### 3. Proofs !

#### 🌞 Prouver que ça fonctionne, rendu attendu :

* Sortie du terraform apply

      PS C:\Users\user\terraform_vm> terraform apply
      
      data.http.my_ip: Reading...
      data.http.my_ip: Read complete after 0s [id=https://api.ipify.org]
      azurerm_resource_group.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg]
      azurerm_public_ip.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
      azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
      azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet]
      azurerm_subnet.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
      azurerm_network_interface.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic]
      azurerm_network_interface_security_group_association.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic|/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
      azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm]
      
      Terraform used the selected providers to generate the following execution plan. Resource actions are
      indicated with the following symbols:
        ~ update in-place
      
      Terraform will perform the following actions:
      
        # azurerm_network_security_group.main will be updated in-place
        ~ resource "azurerm_network_security_group" "main" {
              id                  = "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg"
              name                = "vm-nsg"
            ~ security_rule       = [
                - {
                    - access                                     = "Allow"
                    - destination_address_prefix                 = "*"
                    - destination_address_prefixes               = []
                    - destination_application_security_group_ids = []
                    - destination_port_range                     = "22"
                    - destination_port_ranges                    = []
                    - direction                                  = "Inbound"
                    - name                                       = "SSH"
                    - priority                                   = 1001
                    - protocol                                   = "Tcp"
                    - source_address_prefix                      = "46.193.56.206"
                    - source_address_prefixes                    = []
                    - source_application_security_group_ids      = []
                    - source_port_range                          = "*"
                    - source_port_ranges                         = []
                      # (1 unchanged attribute hidden)
                  },
                + {
                    + access                                     = "Allow"
                    + destination_address_prefix                 = "*"
                    + destination_address_prefixes               = []
                    + destination_application_security_group_ids = []
                    + destination_port_range                     = "22"
                    + destination_port_ranges                    = []
                    + direction                                  = "Inbound"
                    + name                                       = "allow_ssh_from_my_ip"
                    + priority                                   = 100
                    + protocol                                   = "Tcp"
                    + source_address_prefix                      = "46.193.56.206/32"
                    + source_address_prefixes                    = []
                    + source_application_security_group_ids      = []
                    + source_port_range                          = "*"
                    + source_port_ranges                         = []
                      # (1 unchanged attribute hidden)
                  },
              ]
              tags                = {}
              # (2 unchanged attributes hidden)
          }
      
      Plan: 0 to add, 1 to change, 0 to destroy.
      
      Do you want to perform these actions?
        Terraform will perform the actions described above.
        Only 'yes' will be accepted to approve.
      
        Enter a value: yes
      
      azurerm_network_security_group.main: Modifying... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
      azurerm_network_security_group.main: Modifications complete after 3s [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
      
      Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
      
      Outputs:
      
      vm_public_ip = "4.233.85.200"

  * Une commande az pour obtenir toutes les infos liées à la VM
 
          PS C:\Users\user\terraform_vm> az network nic show --ids /subscriptions/xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic --query "networkSecurityGroup" -o json
    
        {
          "id": "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg",
          "resourceGroup": "tp1-rg"
        }
* Une commande ssh fonctionnelle
  
      PS C:\Users\user\terraform_vm> ssh hadime@4.233.85.200
      
      Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)
      
       * Documentation:  https://help.ubuntu.com
       * Management:     https://landscape.canonical.com
       * Support:        https://ubuntu.com/pro
      
       System information as of Mon Sep 15 17:31:10 UTC 2025
      
        System load:  0.0               Processes:             111
        Usage of /:   5.5% of 28.89GB   Users logged in:       0
        Memory usage: 31%               IPv4 address for eth0: 10.0.1.4
        Swap usage:   0%
      
      
      Expanded Security Maintenance for Applications is not enabled.
      
      0 updates can be applied immediately.
      
      Enable ESM Apps to receive additional future security updates.
      See https://ubuntu.com/esm or run: sudo pro status
      
      
      The list of available updates is more than a week old.
      To check for new updates run: sudo apt update
      New release '22.04.5 LTS' available.
      Run 'do-release-upgrade' to upgrade to it.
      
      
      Last login: Mon Sep 15 14:09:28 2025 from 209.206.8.253
      To run a command as administrator (user "root"), use "sudo <command>".
      See "man sudo_root" for details.
      
      hadime@terraform-vm:~$
  
* Changement de port :
  
    *Prouvez que le serveur OpenSSH écoute sur ce nouveau port (avec une commande ss sur la VM)
  
      hadime@terraform-vm:~$ ss -tulpn | grep :2222
      
      tcp    LISTEN  0       128            0.0.0.0:2222        0.0.0.0:*
      tcp    LISTEN  0       128               [::]:2222           [::]:*
  
    *Prouvez qu'une nouvelle connexion sur ce port 2222/tcp ne fonctionne pas à cause du NSG

      PS C:\Users\user\terraform_vm> ssh -p 2222 hadime@4.233.85.200
      
      ssh: connect to host 4.233.85.200 port 2222: Connection timed out
      PS C:\Users\user\terraform_vm>

## II. Un ptit nom DNS

### 1. Adapter le plan Terraform

#### 🌞 Donner un nom DNS à votre VM

### 2. Ajouter un output custom à terraform apply

#### 🌞 Un ptit output nan ?

### 3. Proooofs !

#### 🌞 Proofs ! Donnez moi :


## III. Blob storage


### 2. Let's go

#### 🌞 Compléter votre plan Terraform pour déployer du Blob Storage pour votre VM


### 3. Proooooooofs

#### 🌞 Prouvez que tout est bien configuré, depuis la VM Azure

#### 🌞 Déterminez comment azcopy login --identity vous a authentifié

#### 🌞 Requêtez un JWT d'authentification auprès du service que vous venez d'identifier, manuellement

#### 🌞 Expliquez comment l'IP 169.254.169.254 peut être joignable
