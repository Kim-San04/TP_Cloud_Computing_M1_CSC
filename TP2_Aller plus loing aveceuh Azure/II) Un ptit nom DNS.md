## II. Un ptit nom DNS

### 1. Adapter le plan Terraform

#### 🌞 Donner un nom DNS à votre VM

    PS C:\Users\user\terraform_vm> terraform apply
    
    
    data.http.my_ip: Reading...
    data.http.my_ip: Read complete after 0s [id=https://api.ipify.org]
    azurerm_resource_group.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg]
    azurerm_public_ip.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
    azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet]
    azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
    azurerm_subnet.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
    azurerm_network_interface.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic]
    azurerm_network_interface_security_group_association.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic|/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
    azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm]
    
    Terraform used the selected providers to generate the following execution plan. Resource actions are
    indicated with the following symbols:
      ~ update in-place
    
    Terraform will perform the following actions:
    
      # azurerm_public_ip.main will be updated in-place
      ~ resource "azurerm_public_ip" "main" {
          + domain_name_label       = "hadime-tp2-vm"
            id                      = "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip"
            name                    = "vm-ip"
            tags                    = {}
            # (12 unchanged attributes hidden)
        }
    
    Plan: 0 to add, 1 to change, 0 to destroy.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    azurerm_public_ip.main: Modifying... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
    azurerm_public_ip.main: Modifications complete after 6s [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
    
    Apply complete! Resources: 0 added, 1 changed, 0 destroyed.
    

#### 🌞 Proofs ! Donnez moi :

#### 1

    PS C:\Users\user\terraform_vm> terraform apply

    
    data.http.my_ip: Reading...
    data.http.my_ip: Read complete after 0s [id=https://api.ipify.org]
    azurerm_resource_group.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg]
    azurerm_public_ip.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
    azurerm_network_security_group.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
    azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet]
    azurerm_subnet.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
    azurerm_network_interface.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic]
    azurerm_network_interface_security_group_association.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic|/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Network/networkSecurityGroups/vm-nsg]
    azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm]
    
    Changes to Outputs:
      + vm_dns_name  = "hadime-tp2-vm.francecentral.cloudapp.azure.com"
    
    You can apply this plan to save these new output values to the Terraform state, without changing any
    real infrastructure.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    
    Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
    
    Outputs:
    
    vm_dns_name = "hadime-tp2-vm.francecentral.cloudapp.azure.com"
    vm_public_ip = "x.x.x.x"

#### 2

    PS C:\Users\user\terraform_vm> ssh hadime@had<......>.francecentral.cloudapp.azure.com
    Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/pro
    
     System information as of Mon Sep 15 18:38:10 UTC 2025
    
      System load:  0.0               Processes:             110
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
    
    
    Last login: Mon Sep 15 18:35:15 2025 from 46.193.56.206
    hadime@terraform-vm:~$


