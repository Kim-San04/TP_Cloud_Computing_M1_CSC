### V. Azure Vault
#### 2. Do it !
#### 🌞 Compléter votre plan Terraform et mettez en place une Azure Key Vault

Voir fichier joint
 
#### 3. Proof proof proof¶
#### 🌞 Avec une commande az, afficher le secret

* depuis votre poste, et votre compte Azure, vous avez les droits pour voir le secret normalement
* ça va se faire avec un az keyvault secret show --name "<Le nom de ton secret ici>" --vault-name "<Le nom de ta Azure Key Vault ici>"

      PS C:\Users\user\terraform_vm> az keyvault secret show --name vm-secret --vault-name hadime-vault --query value --output tsv
  
      *Wmxxxxxxxxxxxx

#### 🌞 Depuis la VM, afficher le secret


* il faut donc faire une requête à la Azure Key Vault depuis la VM Azure

* un ptit script shell ça le fait !

J'ai ecrit un petit scipt 'get-secret.sh' et je le rend exécutable par la suite pour afficher le secret dans la VM:

    #!/bin/bash
    
    SECRET_NAME="vm-secret"
    VAULT_NAME="hadime-vault"
    API_VERSION="7.0"
    
    ACCESS_TOKEN=$(curl -s -H "Metadata:true" \
      "http://169.254.169.254/metadata/identity/oauth2/token?api-version=2018-02-01&resource=https://vault.azure.net" \
      | jq -r .access_token)
    
    SECRET_VALUE=$(curl -s -H "Authorization: Bearer $ACCESS_TOKEN" \
      "https://${VAULT_NAME}.vault.azure.net/secrets/${SECRET_NAME}?api-version=${API_VERSION}" \
      | jq -r .value)
    
    echo "Secret récupéré depuis la VM : $SECRET_VALUE"
    
    --------------------------------------------------------------------------------------------

    hadime@terraform-vm:~$ ./get-secret.sh
    
    Secret récupéré depuis la VM : *Wmxxxxxxxxxxxx

