# COMPTE_RENDU_TP1 : Azure first steps
## I. Prérequis
### 2. Une paire de clés SSH
### A. Choix de l'algorithme de chiffrement

### 🌞 Déterminer quel algorithme de chiffrement utiliser pour vos clés
  
   Pourquoi éviter RSA ?
  
  RSA avec l’algorithme  repose sur SHA-1, qui est désormais considéré comme vulnérable aux attaques par collision. OpenSSH a officiellement déprécié ssh-rsa depuis la version 8.2.
  Source fiable : https://www.golinuxcloud.com/sshd-ssh-rsa-algorithm-is-disabled-solved/
  
   Quel algorithme utiliser ?
   
  L’alternative recommandée est Ed25519, qui offre :
  • 	Une sécurité élevée
  • 	Des performances rapides
  • 	Une taille de clé fixe (256 bits)
  • 	Une indépendance vis-à-vis des courbes NIST (contrairement à ECDSA)
  Source fiable : https://vulnerx.com/ssh-key-algorithms/
  
### B. Génération de votre paire de clés

### 🌞 Générer une paire de clés pour ce TP

    PS C:\WINDOWS\system32> ssh-keygen -t ed25519 -f "$env:USERPROFILE\.ssh\cloud_tp1" -C "cloud_tp1 key" -N "************"
    
    Generating public/private ed25519 key pair.
    Your identification has been saved in C:\Users\user\.ssh\cloud_tp1
    Your public key has been saved in C:\Users\user\.ssh\cloud_tp1.pub
    The key fingerprint is:
    SHA256:FJpYkSMNKq2zn42Vrs5HjNe/Y7tqpHDQcCOYpwMzXMs cloud_tp1 key
    The key's randomart image is:
    +--[ED25519 256]--+
    |.o...ooo.        |
    |*o=.=o+o .       |
    |o=oE.oo..        |
    |oo. .  .         |
    |o. + .  S        |
    | oo =.o          |
    |.  =oo .         |
    | o *o . +        |
    | .Boo..o+=       |
    +----[SHA256]-----+

### 🌞 Configurer un agent SSH sur votre poste

1. Activation du service ssh-agent :

       PS C:\WINDOWS\system32> Get-Service ssh-agent
   
    Il était arrêté donc
       
       PS C:\WINDOWS\system32> Start-Service ssh-agent
       PS C:\WINDOWS\system32> Set-Service -Name ssh-agent -StartupType Automatic


2. Ajout de ma clé à l’agent :

       PS C:\WINDOWS\system32> ssh-add $env:USERPROFILE\.ssh\cloud_tp1
   
       Enter passphrase for C:\Users\user\.ssh\cloud_tp1:
       Identity added: C:\Users\user\.ssh\cloud_tp1 (cloud_tp1 key)

3.Petite vérification pour confirmer que la clé est bien chargée :

        PS C:\WINDOWS\system32> ssh-add -l
        
        256 SHA256:FJpYkSMNKq2zn42Vrs5HjNe/Y7tqpHDQcCOYpwMzXMs cloud_tp1 key (ED25519)

## II. Spawn des VMs
### 🌞 Connectez-vous en SSH à la VM pour preuve

    PS C:\WINDOWS\system32> ssh -i $env:USERPROFILE\.ssh\cloud_tp1 azureuser@20.19.91.35
    
    Welcome to Ubuntu 24.04.3 LTS (GNU/Linux 6.11.0-1018-azure x86_64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/pro
    
     System information as of Mon Sep 15 12:45:32 UTC 2025
    
      System load:  0.16              Processes:             135
      Usage of /:   5.6% of 28.02GB   Users logged in:       0
      Memory usage: 3%                IPv4 address for eth0: 172.16.0.4
      Swap usage:   0%
    
    Expanded Security Maintenance for Applications is not enabled.
    
    0 updates can be applied immediately.
    
    Enable ESM Apps to receive additional future security updates.
    See https://ubuntu.com/esm or run: sudo pro status
    
    
    The list of available updates is more than a week old.
    To check for new updates run: sudo apt update
    
    
    The programs included with the Ubuntu system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.
    
    Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
    applicable law.
    
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.
    
    azureuser@Ubuntu:~$

### 2. az : a programmatic approach
### 🌞 Créez une VM depuis le Azure CLI

#### Créer un groupe de ressources

    PS C:\WINDOWS\system32> az group create --location francecentral --name tp1-rg


#### Créer la VM avec ta clé publique

    PS C:\WINDOWS\system32> az vm create `
    >>   --resource-group tp1-rg `
    >>   --name tp1-vm `
    >>   --image Ubuntu2204 `
    >>   --admin-username hadime `
    >>   --ssh-key-values "$env:USERPROFILE\.ssh\cloud_tp1.pub" `
    >>   --size Standard_B1s `
    >>   --location francecentral
    
    The default value of '--size' will be changed to 'Standard_D2s_v5' from 'Standard_DS1_v2' in a future release.
    Selecting "northeurope" may reduce your costs. The region you've selected may cost more for the same services. You can disable this message in the future with the command "az config set core.display_region_identified=false". Learn more at https://go.microsoft.com/fwlink/?linkid=222571
    
    {
      "fqdns": "",
      "id": "/subscriptions/XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/tp1-vm",
      "location": "francecentral",
      "macAddress": "60-45-BD-19-CB-F9",
      "powerState": "VM running",
      "privateIpAddress": "10.0.0.4",
      "publicIpAddress": "20.19.161.50",
      "resourceGroup": "tp1-rg"
    }

### 🌞 Assurez-vous que vous pouvez vous connecter à la VM en SSH sur son IP publique

#### Récupération de l'IP public de la VM

    PS C:\WINDOWS\system32> az vm show -d -g tp1-rg -n tp1-vm --query publicIps -o tsv
    
    20.19.161.50

#### Connexion a la VM

    PS C:\WINDOWS\system32> ssh hadime@20.19.161.50
    
    The authenticity of host '20.19.161.50 (20.19.161.50)' can't be established.
    ED25519 key fingerprint is SHA256:ePuVuRbc78qxtX4XjVZbTv3/mzr7UyuQMWbY9LN7o/A.
    This key is not known by any other names.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added '20.19.161.50' (ED25519) to the list of known hosts.
    Welcome to Ubuntu 22.04.5 LTS (GNU/Linux 6.8.0-1031-azure x86_64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/pro
    
     System information as of Mon Sep 15 13:11:50 UTC 2025
    
      System load:  0.0               Processes:             105
      Usage of /:   5.4% of 28.89GB   Users logged in:       0
      Memory usage: 30%               IPv4 address for eth0: 10.0.0.4
      Swap usage:   0%
    
     * Strictly confined Kubernetes makes edge and IoT secure. Learn how MicroK8s
       just raised the bar for easy, resilient and secure K8s cluster deployment.
    
       https://ubuntu.com/engage/secure-kubernetes-at-the-edge
    
    Expanded Security Maintenance for Applications is not enabled.
    
    0 updates can be applied immediately.
    
    Enable ESM Apps to receive additional future security updates.
    See https://ubuntu.com/esm or run: sudo pro status
    
    
    The list of available updates is more than a week old.
    To check for new updates run: sudo apt update
    
    
    The programs included with the Ubuntu system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.
    
    Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
    applicable law.
    
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.
    
    hadime@tp1-vm:~$

### 🌞 Une fois connecté, prouvez la présence...

* ...du service walinuxagent.service
  
      hadime@tp1-vm:~$ systemctl status walinuxagent.service
  
      Warning: The unit file, source configuration file or drop-ins of walinuxagent.service changed on disk. >
      ● walinuxagent.service - Azure Linux Agent
           Loaded: loaded (/lib/systemd/system/walinuxagent.service; enabled; vendor preset: enabled)
          Drop-In: /run/systemd/system.control/walinuxagent.service.d
                   └─50-CPUAccounting.conf, 50-MemoryAccounting.conf
           Active: active (running) since Mon 2025-09-15 13:03:30 UTC; 13min ago
         Main PID: 748 (python3)
            Tasks: 7 (limit: 1009)
           Memory: 46.5M
              CPU: 2.335s
           CGroup: /system.slice/walinuxagent.service
                   ├─ 748 /usr/bin/python3 -u /usr/sbin/waagent -daemon
                   └─1447 python3 -u bin/WALinuxAgent-2.14.0.1-py3.12.egg -run-exthandlers
      
      Sep 15 13:03:44 tp1-vm python3[1447]:        0        0 ACCEPT     tcp  --  *      *       0.0.0.0/0   >
      Sep 15 13:03:44 tp1-vm python3[1447]:        0        0 ACCEPT     tcp  --  *      *       0.0.0.0/0   >
      Sep 15 13:03:44 tp1-vm python3[1447]:        0        0 DROP       tcp  --  *      *       0.0.0.0/0   >
      Sep 15 13:03:45 tp1-vm python3[1447]: 2025-09-15T13:03:45.329050Z INFO ExtHandler ExtHandler Looking fo>
      Sep 15 13:03:45 tp1-vm python3[1447]: 2025-09-15T13:03:45.331046Z INFO ExtHandler ExtHandler [HEARTBEAT>
      Sep 15 13:08:44 tp1-vm python3[1447]: 2025-09-15T13:08:44.216935Z INFO CollectLogsHandler ExtHandler Wi>
      Sep 15 13:08:44 tp1-vm python3[1447]: 2025-09-15T13:08:44.217108Z INFO CollectLogsHandler ExtHandler Wi>
      Sep 15 13:08:44 tp1-vm python3[1447]: 2025-09-15T13:08:44.217209Z INFO CollectLogsHandler ExtHandler St>
      Sep 15 13:08:56 tp1-vm python3[1447]: 2025-09-15T13:08:56.458384Z INFO CollectLogsHandler ExtHandler Su>
      Sep 15 13:08:56 tp1-vm python3[1447]: 2025-09-15T13:08:56.475157Z INFO CollectLogsHandler ExtHandler Su>
      lines 1-24/24 (END)
  
  * ...du service cloud-init.service
 
        hadime@tp1-vm:~$ systemctl status cloud-init.service
    
        ● cloud-init.service - Cloud-init: Network Stage
             Loaded: loaded (/lib/systemd/system/cloud-init.service; enabled; vendor preset: enabled)
             Active: active (exited) since Mon 2025-09-15 13:03:29 UTC; 15min ago
           Main PID: 504 (code=exited, status=0/SUCCESS)
                CPU: 1.419s
        
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |           .     |
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |          + .   .|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |       . . * o  =|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |      . S o.+.o==|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |       . . oo++o=|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |        .  .=oo.*|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |         . .+* OB|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: |          ...E&OX|
        Sep 15 13:03:29 tp1-vm cloud-init[508]: +----[SHA256]-----+
        Sep 15 13:03:29 tp1-vm systemd[1]: Finished Cloud-init: Network Stage.


### 3. Terraforming planets infrastructures

#### 🌞 Utilisez Terraform pour créer une VM dans Azure

* Création d'un nouveau dossier :

      PS C:\Users\user> mkdir terraform_vm
    
    
        Répertoire : C:\Users\user
    
    
      Mode                 LastWriteTime         Length Name
      ----                 -------------         ------ ----
      d-----        15/09/2025     15:32                terraform_vm


* Création des 3 fichier suivant: -main.tf
                                  -variables.tf
                                  -terraform.tfvars

### Déploiement de la VM

#### Etape 1: terraform init

    PS C:\Users\user\terraform_vm> terraform init
    
    Initializing the backend...
    Initializing provider plugins...
    - Finding latest version of hashicorp/azurerm...
    - Installing hashicorp/azurerm v4.44.0...
    - Installed hashicorp/azurerm v4.44.0 (signed by HashiCorp)
    Terraform has created a lock file .terraform.lock.hcl to record the provider
    selections it made above. Include this file in your version control repository
    so that Terraform can guarantee to make the same selections by default when
    you run "terraform init" in the future.
    
    Terraform has been successfully initialized!
    
    You may now begin working with Terraform. Try running "terraform plan" to see
    any changes that are required for your infrastructure. All Terraform commands
    should now work.
    
    If you ever set or change modules or backend configuration for Terraform,
    rerun this command to reinitialize your working directory. If you forget, other
    commands will detect it and remind you to do so if necessary.

#### Etape 2: terraform plan

    PS C:\Users\user\terraform_vm> terraform plan
    
    Terraform used the selected providers to generate the following execution plan. Resource actions are
    indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # azurerm_linux_virtual_machine.main will be created
      + resource "azurerm_linux_virtual_machine" "main" {
          + admin_username                                         = "hadime"
          + allow_extension_operations                             = (known after apply)
          + bypass_platform_safety_checks_on_user_schedule_enabled = false
          + computer_name                                          = (known after apply)
          + disable_password_authentication                        = (known after apply)
          + disk_controller_type                                   = (known after apply)
          + extensions_time_budget                                 = "PT1H30M"
          + id                                                     = (known after apply)
          + location                                               = "francecentral"
          + max_bid_price                                          = -1
          + name                                                   = "terraform-vm"
          + network_interface_ids                                  = (known after apply)
          + os_managed_disk_id                                     = (known after apply)
          + patch_assessment_mode                                  = (known after apply)
          + patch_mode                                             = (known after apply)
          + platform_fault_domain                                  = -1
          + priority                                               = "Regular"
          + private_ip_address                                     = (known after apply)
          + private_ip_addresses                                   = (known after apply)
          + provision_vm_agent                                     = (known after apply)
          + public_ip_address                                      = (known after apply)
          + public_ip_addresses                                    = (known after apply)
          + resource_group_name                                    = "tp1-rg"
          + size                                                   = "Standard_B1s"
          + virtual_machine_id                                     = (known after apply)
          + vm_agent_platform_updates_enabled                      = (known after apply)
    
          + admin_ssh_key {
              + public_key = <<-EOT
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrtIByT2E7E62u0e5d2OnRS9RjsTv/DA9M2qg4HvObd cloud_tp1 key
                EOT
              + username   = "hadime"
            }
    
          + os_disk {
              + caching                   = "ReadWrite"
              + disk_size_gb              = (known after apply)
              + id                        = (known after apply)
              + name                      = "vm-os-disk"
              + storage_account_type      = "Standard_LRS"
              + write_accelerator_enabled = false
            }
    
          + source_image_reference {
              + offer     = "0001-com-ubuntu-server-focal"
              + publisher = "Canonical"
              + sku       = "20_04-lts"
              + version   = "latest"
            }
    
          + termination_notification (known after apply)
        }
    
      # azurerm_network_interface.main will be created
      + resource "azurerm_network_interface" "main" {
          + accelerated_networking_enabled = false
          + applied_dns_servers            = (known after apply)
          + id                             = (known after apply)
          + internal_domain_name_suffix    = (known after apply)
          + ip_forwarding_enabled          = false
          + location                       = "francecentral"
          + mac_address                    = (known after apply)
          + name                           = "vm-nic"
          + private_ip_address             = (known after apply)
          + private_ip_addresses           = (known after apply)
          + resource_group_name            = "tp1-rg"
          + virtual_machine_id             = (known after apply)
    
          + ip_configuration {
              + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
              + name                                               = "internal"
              + primary                                            = (known after apply)
              + private_ip_address                                 = (known after apply)
              + private_ip_address_allocation                      = "Dynamic"
              + private_ip_address_version                         = "IPv4"
              + public_ip_address_id                               = (known after apply)
              + subnet_id                                          = (known after apply)
            }
        }
    
      # azurerm_public_ip.main will be created
      + resource "azurerm_public_ip" "main" {
          + allocation_method       = "Dynamic"
          + ddos_protection_mode    = "VirtualNetworkInherited"
          + fqdn                    = (known after apply)
          + id                      = (known after apply)
          + idle_timeout_in_minutes = 4
          + ip_address              = (known after apply)
          + ip_version              = "IPv4"
          + location                = "francecentral"
          + name                    = "vm-ip"
          + resource_group_name     = "tp1-rg"
          + sku                     = "Basic"
          + sku_tier                = "Regional"
        }
    
      # azurerm_resource_group.main will be created
      + resource "azurerm_resource_group" "main" {
          + id       = (known after apply)
          + location = "francecentral"
          + name     = "tp1-rg"
        }
    
      # azurerm_subnet.main will be created
      + resource "azurerm_subnet" "main" {
          + address_prefixes                              = [
              + "10.0.1.0/24",
            ]
          + default_outbound_access_enabled               = true
          + id                                            = (known after apply)
          + name                                          = "vm-subnet"
          + private_endpoint_network_policies             = "Disabled"
          + private_link_service_network_policies_enabled = true
          + resource_group_name                           = "tp1-rg"
          + virtual_network_name                          = "vm-vnet"
        }
    
      # azurerm_virtual_network.main will be created
      + resource "azurerm_virtual_network" "main" {
          + address_space                  = [
              + "10.0.0.0/16",
            ]
          + dns_servers                    = (known after apply)
          + guid                           = (known after apply)
          + id                             = (known after apply)
          + location                       = "francecentral"
          + name                           = "vm-vnet"
          + private_endpoint_vnet_policies = "Disabled"
          + resource_group_name            = "tp1-rg"
          + subnet                         = (known after apply)
        }
    
    Plan: 6 to add, 0 to change, 0 to destroy.
    
    ───────────────────────────────────────────────────────────────────────────────────────────────────────
    
    Note: You didn't use the -out option to save this plan, so Terraform can't guarantee to take exactly
    these actions if you run "terraform apply" now.


#### Etape 3: terraform apply

     PS C:\Users\user\terraform_vm> terraform apply
     
    azurerm_resource_group.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg]
    azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet]
    azurerm_subnet.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
    
    Terraform used the selected providers to generate the following execution plan. Resource actions are
    indicated with the following symbols:
      + create
    
    Terraform will perform the following actions:
    
      # azurerm_linux_virtual_machine.main will be created
      + resource "azurerm_linux_virtual_machine" "main" {
          + admin_username                                         = "hadime"
          + allow_extension_operations                             = (known after apply)
          + bypass_platform_safety_checks_on_user_schedule_enabled = false
          + computer_name                                          = (known after apply)
          + disable_password_authentication                        = (known after apply)
          + disk_controller_type                                   = (known after apply)
          + extensions_time_budget                                 = "PT1H30M"
          + id                                                     = (known after apply)
          + location                                               = "francecentral"
          + max_bid_price                                          = -1
          + name                                                   = "terraform-vm"
          + network_interface_ids                                  = (known after apply)
          + os_managed_disk_id                                     = (known after apply)
          + patch_assessment_mode                                  = (known after apply)
          + patch_mode                                             = (known after apply)
          + platform_fault_domain                                  = -1
          + priority                                               = "Regular"
          + private_ip_address                                     = (known after apply)
          + private_ip_addresses                                   = (known after apply)
          + provision_vm_agent                                     = (known after apply)
          + public_ip_address                                      = (known after apply)
          + public_ip_addresses                                    = (known after apply)
          + resource_group_name                                    = "tp1-rg"
          + size                                                   = "Standard_B1s"
          + virtual_machine_id                                     = (known after apply)
          + vm_agent_platform_updates_enabled                      = (known after apply)
    
          + admin_ssh_key {
              + public_key = <<-EOT
                    ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBrtIByT2E7E62u0e5d2OnRS9RjsTv/DA9M2qg4HvObd cloud_tp1 key
                EOT
              + username   = "hadime"
            }
    
          + os_disk {
              + caching                   = "ReadWrite"
              + disk_size_gb              = (known after apply)
              + id                        = (known after apply)
              + name                      = "vm-os-disk"
              + storage_account_type      = "Standard_LRS"
              + write_accelerator_enabled = false
            }
    
          + source_image_reference {
              + offer     = "0001-com-ubuntu-server-focal"
              + publisher = "Canonical"
              + sku       = "20_04-lts"
              + version   = "latest"
            }
    
          + termination_notification (known after apply)
        }
    
      # azurerm_network_interface.main will be created
      + resource "azurerm_network_interface" "main" {
          + accelerated_networking_enabled = false
          + applied_dns_servers            = (known after apply)
          + id                             = (known after apply)
          + internal_domain_name_suffix    = (known after apply)
          + ip_forwarding_enabled          = false
          + location                       = "francecentral"
          + mac_address                    = (known after apply)
          + name                           = "vm-nic"
          + private_ip_address             = (known after apply)
          + private_ip_addresses           = (known after apply)
          + resource_group_name            = "tp1-rg"
          + virtual_machine_id             = (known after apply)
    
          + ip_configuration {
              + gateway_load_balancer_frontend_ip_configuration_id = (known after apply)
              + name                                               = "internal"
              + primary                                            = (known after apply)
              + private_ip_address                                 = (known after apply)
              + private_ip_address_allocation                      = "Dynamic"
              + private_ip_address_version                         = "IPv4"
              + public_ip_address_id                               = (known after apply)
              + subnet_id                                          = "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet"
            }
        }
    
      # azurerm_public_ip.main will be created
      + resource "azurerm_public_ip" "main" {
          + allocation_method       = "Static"
          + ddos_protection_mode    = "VirtualNetworkInherited"
          + fqdn                    = (known after apply)
          + id                      = (known after apply)
          + idle_timeout_in_minutes = 4
          + ip_address              = (known after apply)
          + ip_version              = "IPv4"
          + location                = "francecentral"
          + name                    = "vm-ip"
          + resource_group_name     = "tp1-rg"
          + sku                     = "Standard"
          + sku_tier                = "Regional"
        }
    
    Plan: 3 to add, 0 to change, 0 to destroy.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    azurerm_public_ip.main: Creating...
    azurerm_public_ip.main: Creation complete after 3s [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
    azurerm_network_interface.main: Creating...
    azurerm_network_interface.main: Still creating... [00m10s elapsed]
    azurerm_network_interface.main: Creation complete after 12s [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic]
    azurerm_linux_virtual_machine.main: Creating...
    azurerm_linux_virtual_machine.main: Still creating... [00m10s elapsed]
    azurerm_linux_virtual_machine.main: Creation complete after 14s [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm]
    
    Apply complete! Resources: 3 added, 0 changed, 0 destroyed.
    PS C:\Users\user\terraform_vm> terraform apply
    azurerm_resource_group.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg]
    azurerm_public_ip.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/publicIPAddresses/vm-ip]
    azurerm_virtual_network.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet]
    azurerm_subnet.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/virtualNetworks/vm-vnet/subnets/vm-subnet]
    azurerm_network_interface.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Network/networkInterfaces/vm-nic]
    azurerm_linux_virtual_machine.main: Refreshing state... [id=/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm]
    
    Changes to Outputs:
      + vm_public_ip = "4.233.85.200"
    
    You can apply this plan to save these new output values to the Terraform state, without changing any
    real infrastructure.
    
    Do you want to perform these actions?
      Terraform will perform the actions described above.
      Only 'yes' will be accepted to approve.
    
      Enter a value: yes
    
    
    Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
    
    Outputs:
    
    vm_public_ip = "4.233.85.200"

#### 🌞 Prouvez avec une connexion SSH sur l'IP publique que la VM est up

vm_public_ip = "4.233.85.200"


    PS C:\Users\user\terraform_vm> ssh hadime@4.233.85.200
    
    
    The authenticity of host '4.233.85.200 (4.233.85.200)' can't be established.
    ED25519 key fingerprint is SHA256:Z3WucpSVJPjcbfeGdnDgeOwmGFYKoKPjSXRfH5n2578.
    This key is not known by any other names.
    Are you sure you want to continue connecting (yes/no/[fingerprint])? yes
    Warning: Permanently added '4.233.85.200' (ED25519) to the list of known hosts.
    Welcome to Ubuntu 20.04.6 LTS (GNU/Linux 5.15.0-1089-azure x86_64)
    
     * Documentation:  https://help.ubuntu.com
     * Management:     https://landscape.canonical.com
     * Support:        https://ubuntu.com/pro
    
     System information as of Mon Sep 15 14:09:26 UTC 2025
    
      System load:  0.0               Processes:             111
      Usage of /:   5.3% of 28.89GB   Users logged in:       0
      Memory usage: 30%               IPv4 address for eth0: 10.0.1.4
      Swap usage:   0%
    
    Expanded Security Maintenance for Applications is not enabled.
    
    0 updates can be applied immediately.
    
    Enable ESM Apps to receive additional future security updates.
    See https://ubuntu.com/esm or run: sudo pro status
    
    
    The list of available updates is more than a week old.
    To check for new updates run: sudo apt update
    
    
    The programs included with the Ubuntu system are free software;
    the exact distribution terms for each program are described in the
    individual files in /usr/share/doc/*/copyright.
    
    Ubuntu comes with ABSOLUTELY NO WARRANTY, to the extent permitted by
    applicable law.
    
    To run a command as administrator (user "root"), use "sudo <command>".
    See "man sudo_root" for details.
    
    hadime@terraform-vm:~$

