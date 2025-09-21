### IV. Monitoring

### 2. Une alerte CPU¶
#### 🌞 Compléter votre plan Terraform et mettez en place une alerte CPU

*Voir les fichiers de conf qui ont été joint*

### 3. Alerte mémoire
#### 🌞 Compléter votre plan Terraform et mettez en place une alerte mémoire

*Voir les fichiers de conf qui ont été joint*

### 4. Proofs
### A. Voir les alertes avec az

#### 🌞 Une commande az qui permet de lister les alertes actuellement configurées

    PS C:\Users\user\terraform_vm> az monitor metrics alert list --resource-group tp1-rg --output table
    
    AutoMitigate    Description                                     Enabled    EvaluationFrequency    Location    Name                       ResourceGroup    Severity    TargetResourceRegion    TargetResourceType    WindowSize
    --------------  ----------------------------------------------  ---------  ---------------------  ----------  -------------------------  ---------------  ----------  ----------------------  --------------------  ------------
    True            Alert when available memory is less than 512MB  True       PT1M                   global      memory-alert-terraform-vm  tp1-rg           2                                                         PT5M
    True            Alert when CPU usage exceeds 70%                True       PT1M                   global      cpu-alert-terraform-vm     tp1-rg           2                                                         PT5M

#### on doit voir l'alerte RA



#### on doit voir l'alerte CPU


### B. Stress pour fire les alertes¶
#### 🌞 Stress de la machine


installez le paquet stress-ng dans la VM

    hadime@terraform-vm:~$ sudo apt install stress-ng
    
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    The following additional packages will be installed:
      libipsec-mb0 libjudydebian1 libsctp1
    Suggested packages:
      lksctp-tools
    The following NEW packages will be installed:
      libipsec-mb0 libjudydebian1 libsctp1 stress-ng
    0 upgraded, 4 newly installed, 0 to remove and 41 not upgraded.
    Need to get 2292 kB of archives.
    After this operation, 19.8 MB of additional disk space will be used.
    Do you want to continue? [Y/n] y
    Get:1 http://azure.archive.ubuntu.com/ubuntu focal/universe amd64 libipsec-mb0 amd64 0.53-1 [491 kB]
    Get:2 http://azure.archive.ubuntu.com/ubuntu focal/universe amd64 libjudydebian1 amd64 1.0.5-5 [94.6 kB]
    Get:3 http://azure.archive.ubuntu.com/ubuntu focal/main amd64 libsctp1 amd64 1.0.18+dfsg-1 [7876 B]
    Get:4 http://azure.archive.ubuntu.com/ubuntu focal-updates/universe amd64 stress-ng amd64 0.11.07-1ubuntu2 [1698 kB]
    Fetched 2292 kB in 0s (16.3 MB/s)
    Selecting previously unselected package libipsec-mb0.
    (Reading database ... 59202 files and directories currently installed.)
    Preparing to unpack .../libipsec-mb0_0.53-1_amd64.deb ...
    Unpacking libipsec-mb0 (0.53-1) ...
    Selecting previously unselected package libjudydebian1.
    Preparing to unpack .../libjudydebian1_1.0.5-5_amd64.deb ...
    Unpacking libjudydebian1 (1.0.5-5) ...
    Selecting previously unselected package libsctp1:amd64.
    Preparing to unpack .../libsctp1_1.0.18+dfsg-1_amd64.deb ...
    Unpacking libsctp1:amd64 (1.0.18+dfsg-1) ...
    Selecting previously unselected package stress-ng.
    Preparing to unpack .../stress-ng_0.11.07-1ubuntu2_amd64.deb ...
    Unpacking stress-ng (0.11.07-1ubuntu2) ...
    Setting up libjudydebian1 (1.0.5-5) ...
    Setting up libipsec-mb0 (0.53-1) ...
    Setting up libsctp1:amd64 (1.0.18+dfsg-1) ...
    Setting up stress-ng (0.11.07-1ubuntu2) ...
    Processing triggers for man-db (2.9.1-1) ...
    Processing triggers for libc-bin (2.31-0ubuntu9.17) ...

utilisez la commande stress-ng pour :

stress le CPU (donner la commande)

    hadime@terraform-vm:~$ stress-ng --cpu 4 --timeout 600s
    
    stress-ng: info:  [17976] dispatching hogs: 4 cpu
    
    
    stress-ng: info:  [17976] successful run completed in 600.18s (10 mins, 0.18 secs)

stress la RAM (donner la commande)

    hadime@terraform-vm:~$ stress-ng --vm 2 --vm-bytes 90% --timeout 600s
    stress-ng: info:  [18000] dispatching hogs: 2 vm
    stress-ng: info:  [18000] successful run completed in 600.01s (10 mins, 0.01 secs)
    
#### 🌞 Vérifier que des alertes ont été fired

    PS C:\Users\user\terraform_vm> az monitor activity-log list --resource-group tp1-rg --status Succeeded --output table
    Caller                     CorrelationId                         Description    EventDataId                           EventTimestamp                Level          OperationId                           ResourceGroup    ResourceGroupName    ResourceId                                                                                                                                                                                                                  SubmissionTimestamp    SubscriptionId                        TenantId
    -------------------------  ------------------------------------  -------------  ------------------------------------  ----------------------------  -------------  ------------------------------------  ---------------  -------------------  --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------  ---------------------  ------------------------------------  ------------------------------------
    chxxxxxxxxxxxxo@efrei.net  9916b79b-3d55-5909-35bb-0949329467f3                 217e6ac8-f15b-4561-981c-22ae170af091  2025-09-15T22:27:23.0546708Z  Informational  78e5575c-64cb-4dbf-bf94-f54b7e92f8fc  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourcegroups/tp1-rg/providers/Microsoft.Insights/metricalerts/cpu-alert-terraform-vm                                                                                  2025-09-15T22:39:13Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  9916b79b-3d55-5909-35bb-0949329467f3                 11374938-e884-42ae-89fd-6a1cd83887b9  2025-09-15T22:27:22.6657053Z  Informational  18c02878-b63c-42f7-ae8f-d8660c58a31d  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourcegroups/tp1-rg/providers/Microsoft.Insights/metricalerts/memory-alert-terraform-vm                                                                               2025-09-15T22:29:18Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  9916b79b-3d55-5909-35bb-0949329467f3                 57f5ade4-256f-41c4-8d6f-67a802b7e16f  2025-09-15T22:27:16.074868Z   Informational  1d5ec79d-ae32-4db6-945f-2a3fd161494f  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourcegroups/tp1-rg/providers/Microsoft.Insights/actiongroups/ag-tp1-rg-alerts                                                                                        2025-09-15T22:28:45Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  9916b79b-3d55-5909-35bb-0949329467f3                 254468fd-6334-45e0-a6cf-e4bcf7cf1cc1  2025-09-15T22:17:27.2063322Z  Informational  4007ac2d-ff9c-40ac-8be3-160badd190dc  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/metricAlerts/cpu-alert-terraform-vm                                                                                  2025-09-15T22:19:11Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  9916b79b-3d55-5909-35bb-0949329467f3                 64662d27-33ed-4a3a-9660-b62bb5773f60  2025-09-15T22:17:25.201438Z   Informational  25d5006a-d53b-407f-aaab-70aa31b39dce  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/metricAlerts/memory-alert-terraform-vm                                                                               2025-09-15T22:18:39Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  9916b79b-3d55-5909-35bb-0949329467f3                 dff2bddb-d580-4508-bd03-6ff8945cca2c  2025-09-15T22:17:15.9676626Z  Informational  b0fb59a7-2023-4e0d-a08d-8fa15f8b47d6  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/actionGroups/ag-tp1-rg-alerts                                                                                        2025-09-15T22:19:06Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  f195f709-ea08-4fa6-b24a-f8f763e1adab                 b9dbff12-2724-4a64-be7a-ec09082d53db  2025-09-15T22:16:52.2407859Z  Informational  f195f709-ea08-4fa6-b24a-f8f763e1adab  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T22:18:12Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  13cd8caf-8134-4f4d-a3f2-4837a995fd3d                 cce4bd39-70e8-4020-958b-53f29c5d5b3d  2025-09-15T22:16:50.0791905Z  Informational  13cd8caf-8134-4f4d-a3f2-4837a995fd3d  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T22:17:36Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  6c01b163-20b1-47d7-a34d-20d1a5a4d72a                 43ff6546-b61f-4622-a791-8480d157875a  2025-09-15T22:16:45.7601665Z  Informational  6c01b163-20b1-47d7-a34d-20d1a5a4d72a  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T22:18:08Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 fe2b1649-a1ad-41f8-a7a5-68fca882f68d  2025-09-15T21:17:47.3900748Z  Warning        6d33b984-b842-4339-8ba1-5c656cbac091  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 e3286ddf-0ce6-4e9e-b470-176ff3358931  2025-09-15T21:17:47.3900748Z  Informational  6d33b984-b842-4339-8ba1-5c656cbac091  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 5a522b91-14b5-4e3b-8a56-ff59e3fd8136  2025-09-15T21:17:43.2806733Z  Informational  80e6c2b2-da57-4158-8a3e-f3bf6fdca598  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 b82e0b8b-f9e5-49ed-b2d0-ad06b33eda02  2025-09-15T21:17:43.2650522Z  Warning        80e6c2b2-da57-4158-8a3e-f3bf6fdca598  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 a58d39c4-329d-4f9f-a858-632bf4439157  2025-09-15T21:17:43.2182453Z  Informational  259bf6dc-7a6a-402a-ac74-aaa7cad80f87  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 9b1131ca-d4a7-4eee-a731-647ff976e799  2025-09-15T21:17:43.2025993Z  Warning        259bf6dc-7a6a-402a-ac74-aaa7cad80f87  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 f7725905-a396-46c8-82dd-236831c46046  2025-09-15T21:17:41.7494291Z  Informational  787f9708-8c72-46ab-9012-03450976aee7  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 bbf0acc4-42cc-441e-a43e-107ab4d57ac1  2025-09-15T21:17:41.7494291Z  Informational  744ae203-0f34-47de-b137-ee68a51df73a  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 af69b75a-ffbb-4324-b31e-1388f5dbe156  2025-09-15T21:17:41.7494291Z  Informational  ec437fbe-ee3e-49d6-a102-e0b600f4c045  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 a0fba91e-7a74-4fa4-b1a9-f90fe4fb6afc  2025-09-15T21:17:41.7494291Z  Informational  b32b4c72-709f-4270-af68-691c6f1163bc  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 983ab7af-36b5-4ebc-81ff-0b5e0c1f8ea5  2025-09-15T21:17:41.7494291Z  Informational  9e0c4f50-8730-4d91-9111-e34dc42b5b71  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 7565c8d7-8223-4132-bce1-bae9ea77168f  2025-09-15T21:17:41.7494291Z  Informational  2da5b283-7dcb-4b4a-8c67-112a0e25034b  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 5e6475f1-8565-4271-8f44-ff66963b5acb  2025-09-15T21:17:41.7494291Z  Informational  9c300857-ebea-4e52-8f45-474ceb955cd4  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 5b2d3233-8c78-4556-b848-88184518ad55  2025-09-15T21:17:41.7494291Z  Informational  0e3337be-c8c4-4a7e-bbf3-daa821883479  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 50c029f6-8a8a-44eb-afce-cb0b5acd0d48  2025-09-15T21:17:41.7494291Z  Informational  6ff768c4-04e7-476d-8467-bfaf2014e314  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 3d1dddb9-85ce-4e0e-9a8d-e18415ff222c  2025-09-15T21:17:41.7494291Z  Informational  7ebc45a5-a920-4e7b-9111-2dcc3d920999  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 29539810-8d20-4d39-9076-51e2a05e451a  2025-09-15T21:17:41.7494291Z  Informational  001060f9-925c-4349-913f-b467023318d1  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 070bd3fc-0fee-4d2f-8b8f-b5d5234685a8  2025-09-15T21:17:41.7494291Z  Informational  7889a8e4-179b-4765-8428-67379122b67b  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 0621febe-4204-4cc7-a242-41564f9ea2bc  2025-09-15T21:17:41.7494291Z  Informational  1c7a344c-b5ad-4add-8dd7-a900d932e103  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 e65ccda8-3a9a-4b8b-8778-5ab5d7e05f3d  2025-09-15T21:17:41.7338211Z  Warning        744ae203-0f34-47de-b137-ee68a51df73a  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 b2fde540-36ff-4e8d-bb22-212aeeb26217  2025-09-15T21:17:41.7338211Z  Warning        9e0c4f50-8730-4d91-9111-e34dc42b5b71  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 b1066477-8b14-4fcf-b9e4-c5827397f1be  2025-09-15T21:17:41.7338211Z  Warning        6ff768c4-04e7-476d-8467-bfaf2014e314  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 9a784f29-175a-4de5-bee6-31a539bdde42  2025-09-15T21:17:41.7338211Z  Warning        b32b4c72-709f-4270-af68-691c6f1163bc  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 85575d39-902b-42c9-ab99-428457f45fc7  2025-09-15T21:17:41.7338211Z  Warning        ec437fbe-ee3e-49d6-a102-e0b600f4c045  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 69dd1730-8db1-4026-80cb-83f4a3a42b24  2025-09-15T21:17:41.7338211Z  Warning        2da5b283-7dcb-4b4a-8c67-112a0e25034b  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 5331f29c-0249-474b-be5b-5d3de060560d  2025-09-15T21:17:41.7338211Z  Warning        001060f9-925c-4349-913f-b467023318d1  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 44620462-e4bf-475b-98e9-20b120c560d1  2025-09-15T21:17:41.7338211Z  Warning        0e3337be-c8c4-4a7e-bbf3-daa821883479  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 41d5d89a-0018-4962-b15f-090e31b53c19  2025-09-15T21:17:41.7338211Z  Warning        787f9708-8c72-46ab-9012-03450976aee7  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 3a0e1d6f-1574-45ab-9c4b-797dde9f4309  2025-09-15T21:17:41.7338211Z  Warning        9c300857-ebea-4e52-8f45-474ceb955cd4  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 360237f6-8a11-46df-8deb-071e43a20e79  2025-09-15T21:17:41.7338211Z  Warning        7ebc45a5-a920-4e7b-9111-2dcc3d920999  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 2ddda392-44be-463b-9f16-784f7bf004ea  2025-09-15T21:17:41.7338211Z  Warning        7889a8e4-179b-4765-8428-67379122b67b  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 1ad2ae1d-e36c-4b6e-ba2b-f78a053ff752  2025-09-15T21:17:41.7338211Z  Warning        1c7a344c-b5ad-4add-8dd7-a900d932e103  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm                                                                                          2025-09-15T21:19:26Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  701e828a-6a19-4eb9-849e-f8ff31bb1d2d                 18a4f9bc-3aa9-4eb0-ab81-b7d99d051916  2025-09-15T21:17:38.2119661Z  Informational  2cf51168-f1e5-41ac-9845-b76094cc6dd2  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:19:29Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  701e828a-6a19-4eb9-849e-f8ff31bb1d2d                 a9e3905f-ced5-4cd6-b1ee-8df64a92ea86  2025-09-15T21:17:38.1963425Z  Warning        2cf51168-f1e5-41ac-9845-b76094cc6dd2  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:19:29Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  701e828a-6a19-4eb9-849e-f8ff31bb1d2d                 62083e3f-ecf6-4b66-98e7-bdceedf915df  2025-09-15T21:17:38.1807121Z  Informational  457a8453-0a45-4ac6-adc2-ffdd41a1bde4  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:19:29Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  701e828a-6a19-4eb9-849e-f8ff31bb1d2d                 2ea6c6e9-9b1b-40ce-a81f-6cbbd2836aaa  2025-09-15T21:17:38.1807121Z  Warning        457a8453-0a45-4ac6-adc2-ffdd41a1bde4  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:19:29Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  02f5a14c-551e-e094-434f-196ae70c8cf1                 280a5759-7e3c-4666-8f7d-e9331517afb2  2025-09-15T21:08:45.7904003Z  Informational  079edb68-5561-495d-bf2d-8957908d4edc  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage/providers/Microsoft.Authorization/roleAssignments/b60b9194-38e1-e2bd-7a18-b9e55362237c  2025-09-15T21:10:06Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    cheick.sawadogo@efrei.net  33daf0d1-e041-4fff-944f-84662ea2b100                 0130030e-66fd-4176-9242-c84ce413d12d  2025-09-15T21:08:37.7925657Z  Informational  33daf0d1-e041-4fff-944f-84662ea2b100  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage/blobServices/default/containers/backupcontainer                                         2025-09-15T21:09:46Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  fe45ec65-97cf-4850-b1e4-a37896148563                 0fc1cde1-a46e-4ce6-8c25-9a268a58654c  2025-09-15T21:08:36.6406435Z  Informational  fe45ec65-97cf-4850-b1e4-a37896148563  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:09:27Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  b69d114d-1545-4e67-b71c-3ed526281eb0                 a60fb625-0783-45fc-bc76-1107c3743ff6  2025-09-15T21:08:26.0647597Z  Informational  b69d114d-1545-4e67-b71c-3ed526281eb0  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:09:52Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731
    chxxxxxxxxxxxxo@efrei.net  0f7c4044-a929-47ba-99a1-fbefe1c2e820                 d0a9405e-32d6-40f4-b184-9333b3804005  2025-09-15T21:08:04.8878785Z  Informational  0f7c4044-a929-47ba-99a1-fbefe1c2e820  tp1-rg           tp1-rg               /subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Storage/storageAccounts/hadimestorage                                                                                         2025-09-15T21:10:00Z   38c42894-8fc6-46fe-96ad-97aaca720174  413600cf-bd4e-4c7c-8a61-69e73cddf731

* normalement t'as un mail ( oui le vois bien dans ma boite mail)
  
* tu le vois dans la WebUI Azure( De même pour cette partie)
  
* dans le compte-rendu, je veux une commande az qui montre que les alertes ont été levées ( ci-dessous

      PS C:\Users\user\terraform_vm> az monitor metrics alert update --name cpu-alert-terraform-vm --resource-group tp1-rg --enabled false
      
      {
        "actions": [
          {
            "actionGroupId": "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/actionGroups/ag-tp1-rg-alerts",
            "webHookProperties": {}
          }
        ],
        "autoMitigate": true,
        "criteria": {
          "allOf": [
            {
              "criterionType": "StaticThresholdCriterion",
              "metricName": "Percentage CPU",
              "metricNamespace": "Microsoft.Compute/virtualMachines",
              "name": "Metric1",
              "operator": "GreaterThan",
              "skipMetricValidation": false,
              "threshold": 70.0,
              "timeAggregation": "Average"
            }
          ],
          "odata.type": "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria"
        },
        "description": "Alert when CPU usage exceeds 70%",
        "enabled": false,
        "evaluationFrequency": "PT1M",
        "id": "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/metricAlerts/cpu-alert-terraform-vm",
        "location": "global",
        "name": "cpu-alert-terraform-vm",
        "resourceGroup": "tp1-rg",
        "scopes": [
          "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm"
        ],
        "severity": 2,
        "tags": {},
        "targetResourceRegion": "",
        "targetResourceType": "",
        "type": "Microsoft.Insights/metricAlerts",
        "windowSize": "PT5M"
      }
  
      ---------------------------------------------------------------------------------------------------------------------------------------
  
      PS C:\Users\user\terraform_vm> az monitor metrics alert update --name memory-alert-terraform-vm --resource-group tp1-rg --enabled false
      
      {
        "actions": [
          {
            "actionGroupId": "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/actionGroups/ag-tp1-rg-alerts",
            "webHookProperties": {}
          }
        ],
        "autoMitigate": true,
        "criteria": {
          "allOf": [
            {
              "criterionType": "StaticThresholdCriterion",
              "metricName": "Available Memory Bytes",
              "metricNamespace": "Microsoft.Compute/virtualMachines",
              "name": "Metric1",
              "operator": "LessThan",
              "skipMetricValidation": false,
              "threshold": 536870912.0,
              "timeAggregation": "Average"
            }
          ],
          "odata.type": "Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria"
        },
        "description": "Alert when available memory is less than 512MB",
        "enabled": false,
        "evaluationFrequency": "PT1M",
        "id": "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Insights/metricAlerts/memory-alert-terraform-vm",
        "location": "global",
        "name": "memory-alert-terraform-vm",
        "resourceGroup": "tp1-rg",
        "scopes": [
          "/subscriptions/38c42894-8fc6-46fe-96ad-97aaca720174/resourceGroups/tp1-rg/providers/Microsoft.Compute/virtualMachines/terraform-vm"
        ],
        "severity": 2,
        "tags": {},
        "targetResourceRegion": "",
        "targetResourceType": "",
        "type": "Microsoft.Insights/metricAlerts",
        "windowSize": "PT5M"
      }

          ---------------------------------------------------------------------------------------------------------------------------------------
      
      PS C:\Users\user\terraform_vm> az monitor metrics alert list --resource-group tp1-rg --query "[].{name:name,enabled:enabled}" --output table
      
      Name                       Enabled
      -------------------------  ---------
      memory-alert-terraform-vm  False
      cpu-alert-terraform-vm     False
  
