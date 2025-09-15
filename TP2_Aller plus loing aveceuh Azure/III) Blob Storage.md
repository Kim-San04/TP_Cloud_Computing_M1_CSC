## III. Blob storage


### 2. Let's go

#### 🌞 Compléter votre plan Terraform pour déployer du Blob Storage pour votre VM

voir fichier joint


### 3. Proooooooofs

#### 🌞 Prouvez que tout est bien configuré, depuis la VM Azure

* installez azcopy dans la VM (suivez la doc officielle pour l'installer dans votre VM Azure)

      hadime@terraform-vm:~$ curl -sSL https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -o packages-microsoft-prod.deb
  
      hadime@terraform-vm:~$ sudo dpkg -i packages-microsoft-prod.deb
  
      Selecting previously unselected package packages-microsoft-prod.
      (Reading database ... 59190 files and directories currently installed.)
      Preparing to unpack packages-microsoft-prod.deb ...
      Unpacking packages-microsoft-prod (1.0-ubuntu20.04.1) ...
      Setting up packages-microsoft-prod (1.0-ubuntu20.04.1) ...
  
      hadime@terraform-vm:~$ sudo apt update
  
      Hit:1 http://azure.archive.ubuntu.com/ubuntu focal InRelease
      Hit:2 http://azure.archive.ubuntu.com/ubuntu focal-updates InRelease
      Hit:3 http://azure.archive.ubuntu.com/ubuntu focal-backports InRelease
      Hit:4 http://azure.archive.ubuntu.com/ubuntu focal-security InRelease
      Get:5 https://packages.microsoft.com/ubuntu/20.04/prod focal InRelease [3632 B]
      Get:6 https://packages.microsoft.com/ubuntu/20.04/prod focal/main amd64 Packages [379 kB]
      Get:7 https://packages.microsoft.com/ubuntu/20.04/prod focal/main all Packages [2938 B]
      Get:8 https://packages.microsoft.com/ubuntu/20.04/prod focal/main arm64 Packages [96.6 kB]
      Get:9 https://packages.microsoft.com/ubuntu/20.04/prod focal/main armhf Packages [27.9 kB]
      Fetched 510 kB in 1s (616 kB/s)
      Reading package lists... Done
      Building dependency tree
      Reading state information... Done
      41 packages can be upgraded. Run 'apt list --upgradable' to see them.
  
      hadime@terraform-vm:~$ sudo apt install azcopy
  
      Reading package lists... Done
      Building dependency tree
      Reading state information... Done
      The following NEW packages will be installed:
        azcopy
      0 upgraded, 1 newly installed, 0 to remove and 41 not upgraded.
      Need to get 23.0 MB of archives.
      After this operation, 56.5 MB of additional disk space will be used.
      Get:1 https://packages.microsoft.com/ubuntu/20.04/prod focal/main amd64 azcopy amd64 10.30.1 [23.0 MB]
      Fetched 23.0 MB in 0s (50.7 MB/s)
      Selecting previously unselected package azcopy.
      (Reading database ... 59198 files and directories currently installed.)
      Preparing to unpack .../azcopy_10.30.1_amd64.deb ...
      Unpacking azcopy (10.30.1) ...
      Setting up azcopy (10.30.1) ...
  
      hadime@terraform-vm:~$ azcopy --version
  
      azcopy version 10.30.1

* azcopy login --identity pour vous authentifier automatiquement

      hadime@terraform-vm:~$ azcopy login --identity
      
      INFO: Login with identity succeeded.

* utilisez azcopy pour écrire un fichier dans le Storage Container que vous avez créé
* utilisez azcopy pour lire le fichier que vous venez de push

      hadime@terraform-vm:~$ echo "Hello Hadime" > test.txt
      
      hadime@terraform-vm:~$ azcopy copy "test.txt" 
      "https://<storageaccount>.blob.core.windows.net/<container>/test.txt"
      
      INFO: Scanning...
      INFO: Autologin not specified.
      INFO: Authenticating to destination using Azure AD
      INFO: Any empty folders will not be processed, because source and/or destination doesn't have full folder support
      
      Job 5427871d-b7a4-e943-69a1-2c2d57c730b5 has started
      Log file is located at: /home/hadime/.azcopy/5427871d-b7a4-e943-69a1-2c2d57c730b5.log
      
      100.0 %, 1 Done, 0 Failed, 0 Pending, 0 Skipped, 1 Total, 2-sec Throughput (Mb/s): 0.0001
      
      
      Job 5427871d-b7a4-e943-69a1-2c2d57c730b5 summary
      Elapsed Time (Minutes): 0.0335
      Number of File Transfers: 1
      Number of Folder Property Transfers: 0
      Number of Symlink Transfers: 0
      Total Number of Transfers: 1
      Number of File Transfers Completed: 1
      Number of Folder Transfers Completed: 0
      Number of File Transfers Failed: 0
      Number of Folder Transfers Failed: 0
      Number of File Transfers Skipped: 0
      Number of Folder Transfers Skipped: 0
      Number of Symbolic Links Skipped: 0
      Number of Hardlinks Converted: 0
      Number of Special Files Skipped: 0
      Total Number of Bytes Transferred: 13
      Final Job Status: Completed
      
      hadime@terraform-vm:~$ azcopy copy                         "https://<storageaccount>.blob.core.windows.net/<container>/test.txt" "./downloaded.txt"
      
      INFO: Scanning...
      INFO: Autologin not specified.
      INFO: Authenticating to source using Azure AD
      INFO: Any empty folders will not be processed, because source and/or destination doesn't have full folder support
      
      Job 43f41693-713f-4949-6369-8795b08dfb9c has started
      Log file is located at: /home/hadime/.azcopy/43f41693-713f-4949-6369-8795b08dfb9c.log
      
      100.0 %, 1 Done, 0 Failed, 0 Pending, 0 Skipped, 1 Total, 2-sec Throughput (Mb/s): 0.0001
      
      
      Job 43f41693-713f-4949-6369-8795b08dfb9c summary
      Elapsed Time (Minutes): 0.0334
      Number of File Transfers: 1
      Number of Folder Property Transfers: 0
      Number of Symlink Transfers: 0
      Total Number of Transfers: 1
      Number of File Transfers Completed: 1
      Number of Folder Transfers Completed: 0
      Number of File Transfers Failed: 0
      Number of Folder Transfers Failed: 0
      Number of File Transfers Skipped: 0
      Number of Folder Transfers Skipped: 0
      Number of Symbolic Links Skipped: 0
      Number of Hardlinks Converted: 0
      Number of Special Files Skipped: 0
      Total Number of Bytes Transferred: 13
      Final Job Status: Completed
      
      hadime@terraform-vm:~$ cat downloaded.txt
      
      Hello Hadime


#### 🌞 Déterminez comment azcopy login --identity vous a authentifié

Cette commande interroge l’endpoint spécial http://169.254.169.254 pour obtenir un token JWT.
Ce token est signé par Azure et permet à la VM d’accéder aux ressources autorisées (ici, le Blob Storage).


#### 🌞 Requêtez un JWT d'authentification auprès du service que vous venez d'identifier, manuellement

    hadime@terraform-vm:~$ curl -H "Metadata:true" \
    >   "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://storage.azure.com"
    
    {""access_token":"<jwt_access_token>""}

#### 🌞 Expliquez comment l'IP 169.254.169.254 peut être joignable

Cette IP est une adresse spéciale utilisée par Azure pour exposer les métadonnées de la VM.
Elle est joignable car Azure configure automatiquement une route locale dans la VM :

    hadime@terraform-vm:~$ ip route
    
    default via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100
    10.0.1.0/24 dev eth0 proto kernel scope link src 10.0.1.4 metric 100
    168.63.129.16 via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100
    **169.254.169.254 via 10.0.1.1 dev eth0 proto dhcp src 10.0.1.4 metric 100**




