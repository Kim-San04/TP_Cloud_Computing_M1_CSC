### TP3 : Cloud privé

### I. Présentation du lab
#### 1. Architecture

#### 🌞 Allumez les VMs et effectuez la conf élémentaire :

* ping kvm1.one depuis frontend.one

      [kim@frontend ~]$ ping kvm1.one
  
      PING kvm1.one (10.3.1.11) 56(84) octets de données.
      64 octets de kvm1.one (10.3.1.11) : icmp_seq=1 ttl=64 temps=2.31 ms
      64 octets de kvm1.one (10.3.1.11) : icmp_seq=2 ttl=64 temps=3.50 ms
      64 octets de kvm1.one (10.3.1.11) : icmp_seq=3 ttl=64 temps=0.626 ms
      64 octets de kvm1.one (10.3.1.11) : icmp_seq=4 ttl=64 temps=1.15 ms
      
      - statistiques ping kvm1.one
      4 paquets transmis, 4 reçus, 0% packet loss, time 3051ms
      rtt min/avg/max/mdev = 0.626/1.896/3.496/1.106 ms


* ping kvm2.one depuis frontend.one

      [kim@frontend ~]$ ping kvm2.one
  
      PING kvm2.one (10.3.1.12) 56(84) octets de données.
      64 octets de kvm2.one (10.3.1.12) : icmp_seq=1 ttl=64 temps=1.96 ms
      64 octets de kvm2.one (10.3.1.12) : icmp_seq=2 ttl=64 temps=0.840 ms
      64 octets de kvm2.one (10.3.1.12) : icmp_seq=3 ttl=64 temps=0.641 ms
      64 octets de kvm2.one (10.3.1.12) : icmp_seq=4 ttl=64 temps=1.43 ms
      
      --- statistiques ping kvm2.one -
      4 paquets transmis, 4 reçus, 0% packet loss, time 3042ms
      rtt min/avg/max/mdev = 0.641/1.217/1.958/0.516 ms

### II. Setup
#### 1. Frontend


#### A. Database¶
#### 🌞 Installer un serveur MySQL

on va installer une version spécifique de MySQL, demandée par OpenNebula
ajouter un dépôt :
télécharger le RPM disponible à l'URL suivante : https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
puis installez-le localement avec une commande rpm

    [root@frontend ~]# wget https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
    
    --2025-09-16 16:30:50--  https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
    Resolving dev.mysql.com (dev.mysql.com)... 104.85.37.194, 2a02:26f0:2b80:f95::2e31, 2a02:26f0:2b80:f8d::2e31
    Connecting to dev.mysql.com (dev.mysql.com)|104.85.37.194|:443... connected.
    HTTP request sent, awaiting response... 302 Moved Temporarily
    Location: https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm [following]
    --2025-09-16 16:30:51--  https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm
    Resolving repo.mysql.com (repo.mysql.com)... 104.85.20.87, 2a02:26f0:9100:184::1d68, 2a02:26f0:9100:196::1d68
    Connecting to repo.mysql.com (repo.mysql.com)|104.85.20.87|:443... connected.
    HTTP request sent, awaiting response... 200 OK
    Length: 13319 (13K) [application/x-redhat-package-manager]
    Saving to: ‘mysql80-community-release-el9-5.noarch.rpm’
    
    mysql80-community-release 100%[=====================================>]  13.01K  --.-KB/s    in 0s
    
    2025-09-16 16:30:51 (26.8 MB/s) - ‘mysql80-community-release-el9-5.noarch.rpm’ saved [13319/13319]


 --------------------------------------------------------------------------------------------------------------
    [root@frontend ~]# sudo rpm -ivh mysql80-community-release-el9-5.noarch.rpm
    warning: mysql80-community-release-el9-5.noarch.rpm: Header V4 RSA/SHA256 Signature, key ID 3a79bd29: NOKEY
    Verifying...                          ################################# [100%]
    Preparing...                          ################################# [100%]
    Updating / installing...
       1:mysql80-community-release-el9-5  ################################# [100%]
   
 
installer le paquet qui contient le serveur MySQL depuis ce nouveau dépôt :

   
      [root@frontend ~]# sudo dnf install -y mysql-community-server
      MySQL 8.0 Community Server                                              2.9 MB/s | 2.7 MB     00:00
      MySQL Connectors Community                                              284 kB/s |  90 kB     00:00
      MySQL Tools Community                                                   1.3 MB/s | 1.2 MB     00:00
      Dependencies resolved.
      ========================================================================================================
       Package                            Arch       Version                      Repository             Size
      ========================================================================================================
      Installing:
       mysql-community-server             x86_64     8.0.43-1.el9                 mysql80-community      50 M
      Installing dependencies:
       libtirpc                           x86_64     1.3.3-9.el9                  baseos                 93 k
       mysql-community-client             x86_64     8.0.43-1.el9                 mysql80-community     3.3 M
       mysql-community-client-plugins     x86_64     8.0.43-1.el9                 mysql80-community     1.4 M
       mysql-community-common             x86_64     8.0.43-1.el9                 mysql80-community     556 k
       mysql-community-icu-data-files     x86_64     8.0.43-1.el9                 mysql80-community     2.3 M
       mysql-community-libs               x86_64     8.0.43-1.el9                 mysql80-community     1.5 M
       net-tools                          x86_64     2.0-0.64.20160912git.el9     baseos                294 k
       perl-AutoLoader                    noarch     5.74-481.1.el9_6             appstream              20 k
       perl-B                             x86_64     1.80-481.1.el9_6             appstream             178 k
       perl-Carp                          noarch     1.50-460.el9                 appstream              29 k
       perl-Class-Struct                  noarch     0.66-481.1.el9_6             appstream              21 k
       perl-Data-Dumper                   x86_64     2.174-462.el9                appstream              55 k
       perl-Digest                        noarch     1.19-4.el9                   appstream              25 k
       perl-Digest-MD5                    x86_64     2.58-4.el9                   appstream              36 k
       perl-Encode                        x86_64     4:3.08-462.el9               appstream             1.7 M
       perl-Errno                         x86_64     1.30-481.1.el9_6             appstream              13 k
       perl-Exporter                      noarch     5.74-461.el9                 appstream              31 k
       perl-Fcntl                         x86_64     1.13-481.1.el9_6             appstream              19 k
       perl-File-Basename                 noarch     2.85-481.1.el9_6             appstream              16 k
       perl-File-Path                     noarch     2.18-4.el9                   appstream              35 k
       perl-File-Temp                     noarch     1:0.231.100-4.el9            appstream              59 k
       perl-File-stat                     noarch     1.09-481.1.el9_6             appstream              16 k
       perl-FileHandle                    noarch     2.03-481.1.el9_6             appstream              14 k
       perl-Getopt-Long                   noarch     1:2.52-4.el9                 appstream              60 k
       perl-Getopt-Std                    noarch     1.12-481.1.el9_6             appstream              14 k
       perl-HTTP-Tiny                     noarch     0.076-462.el9                appstream              53 k
       perl-IO                            x86_64     1.43-481.1.el9_6             appstream              85 k
       perl-IO-Socket-IP                  noarch     0.41-5.el9                   appstream              42 k
       perl-IO-Socket-SSL                 noarch     2.073-2.el9                  appstream             214 k
       perl-IPC-Open3                     noarch     1.21-481.1.el9_6             appstream              21 k
       perl-MIME-Base64                   x86_64     3.16-4.el9                   appstream              30 k
       perl-Mozilla-CA                    noarch     20200520-6.el9               appstream              12 k
       perl-Net-SSLeay                    x86_64     1.94-1.el9                   appstream             391 k
       perl-POSIX                         x86_64     1.94-481.1.el9_6             appstream              95 k
       perl-PathTools                     x86_64     3.78-461.el9                 appstream              85 k
       perl-Pod-Escapes                   noarch     1:1.07-460.el9               appstream              20 k
       perl-Pod-Perldoc                   noarch     3.28.01-461.el9              appstream              83 k
       perl-Pod-Simple                    noarch     1:3.42-4.el9                 appstream             215 k
       perl-Pod-Usage                     noarch     4:2.01-4.el9                 appstream              40 k
       perl-Scalar-List-Utils             x86_64     4:1.56-462.el9               appstream              70 k
       perl-SelectSaver                   noarch     1.02-481.1.el9_6             appstream              10 k
       perl-Socket                        x86_64     4:2.031-4.el9                appstream              54 k
       perl-Storable                      x86_64     1:3.21-460.el9               appstream              95 k
       perl-Symbol                        noarch     1.08-481.1.el9_6             appstream              13 k
       perl-Term-ANSIColor                noarch     5.01-461.el9                 appstream              48 k
       perl-Term-Cap                      noarch     1.17-460.el9                 appstream              22 k
       perl-Text-ParseWords               noarch     3.30-460.el9                 appstream              16 k
       perl-Text-Tabs+Wrap                noarch     2013.0523-460.el9            appstream              23 k
       perl-Time-Local                    noarch     2:1.300-7.el9                appstream              33 k
       perl-URI                           noarch     5.09-3.el9                   appstream             108 k
       perl-base                          noarch     2.27-481.1.el9_6             appstream              15 k
       perl-constant                      noarch     1.33-461.el9                 appstream              23 k
       perl-if                            noarch     0.60.800-481.1.el9_6         appstream              13 k
       perl-interpreter                   x86_64     4:5.32.1-481.1.el9_6         appstream              69 k
       perl-libnet                        noarch     3.13-4.el9                   appstream             125 k
       perl-libs                          x86_64     4:5.32.1-481.1.el9_6         appstream             2.0 M
       perl-mro                           x86_64     1.23-481.1.el9_6             appstream              27 k
       perl-overload                      noarch     1.31-481.1.el9_6             appstream              44 k
       perl-overloading                   noarch     0.02-481.1.el9_6             appstream              11 k
       perl-parent                        noarch     1:0.238-460.el9              appstream              14 k
       perl-podlators                     noarch     1:4.14-460.el9               appstream             112 k
       perl-subs                          noarch     1.03-481.1.el9_6             appstream              10 k
       perl-vars                          noarch     1.05-481.1.el9_6             appstream              12 k
      Installing weak dependencies:
       perl-NDBM_File                     x86_64     1.15-481.1.el9_6             appstream              21 k
    
    Transaction Summary
    ========================================================================================================
    Install  65 Packages
    
    Total download size: 66 M
    Installed size: 363 M
    Downloading Packages:
    (1/65): mysql-community-client-plugins-8.0.43-1.el9.x86_64.rpm          3.8 MB/s | 1.4 MB     00:00
    (2/65): mysql-community-common-8.0.43-1.el9.x86_64.rpm                  1.4 MB/s | 556 kB     00:00
    (3/65): mysql-community-libs-8.0.43-1.el9.x86_64.rpm                    8.5 MB/s | 1.5 MB     00:00
    (4/65): mysql-community-icu-data-files-8.0.43-1.el9.x86_64.rpm          5.6 MB/s | 2.3 MB     00:00
    (5/65): net-tools-2.0-0.64.20160912git.el9.x86_64.rpm                   684 kB/s | 294 kB     00:00
    (6/65): libtirpc-1.3.3-9.el9.x86_64.rpm                                 745 kB/s |  93 kB     00:00
    (7/65): perl-Getopt-Long-2.52-4.el9.noarch.rpm                          167 kB/s |  60 kB     00:00
    (8/65): perl-Term-Cap-1.17-460.el9.noarch.rpm                           112 kB/s |  22 kB     00:00
    (9/65): perl-NDBM_File-1.15-481.1.el9_6.x86_64.rpm                      157 kB/s |  21 kB     00:00
    (10/65): mysql-community-client-8.0.43-1.el9.x86_64.rpm                 1.6 MB/s | 3.3 MB     00:02
    (11/65): perl-vars-1.05-481.1.el9_6.noarch.rpm                           78 kB/s |  12 kB     00:00
    (12/65): perl-Pod-Escapes-1.07-460.el9.noarch.rpm                        57 kB/s |  20 kB     00:00
    (13/65): perl-Socket-2.031-4.el9.x86_64.rpm                             217 kB/s |  54 kB     00:00
    (14/65): perl-parent-0.238-460.el9.noarch.rpm                           157 kB/s |  14 kB     00:00
    (15/65): mysql-community-server-8.0.43-1.el9.x86_64.rpm                  21 MB/s |  50 MB     00:02
    (16/65): perl-B-1.80-481.1.el9_6.x86_64.rpm                             717 kB/s | 178 kB     00:00
    (17/65): perl-Scalar-List-Utils-1.56-462.el9.x86_64.rpm                 591 kB/s |  70 kB     00:00
    (18/65): perl-Net-SSLeay-1.94-1.el9.x86_64.rpm                          453 kB/s | 391 kB     00:00
    (19/65): perl-base-2.27-481.1.el9_6.noarch.rpm                          209 kB/s |  15 kB     00:00
    (20/65): perl-PathTools-3.78-461.el9.x86_64.rpm                         342 kB/s |  85 kB     00:00
    (21/65): perl-Getopt-Std-1.12-481.1.el9_6.noarch.rpm                     55 kB/s |  14 kB     00:00
    (22/65): perl-URI-5.09-3.el9.noarch.rpm                                 190 kB/s | 108 kB     00:00
    (23/65): perl-Pod-Perldoc-3.28.01-461.el9.noarch.rpm                    293 kB/s |  83 kB     00:00
    (24/65): perl-File-Basename-2.85-481.1.el9_6.noarch.rpm                 212 kB/s |  16 kB     00:00
    (25/65): perl-Exporter-5.74-461.el9.noarch.rpm                          308 kB/s |  31 kB     00:00
    (26/65): perl-HTTP-Tiny-0.076-462.el9.noarch.rpm                        110 kB/s |  53 kB     00:00
    (27/65): perl-Digest-1.19-4.el9.noarch.rpm                               67 kB/s |  25 kB     00:00
    (28/65): perl-subs-1.03-481.1.el9_6.noarch.rpm                          159 kB/s |  10 kB     00:00
    (29/65): perl-Fcntl-1.13-481.1.el9_6.x86_64.rpm                         271 kB/s |  19 kB     00:00
    (30/65): perl-Text-Tabs+Wrap-2013.0523-460.el9.noarch.rpm               122 kB/s |  23 kB     00:00
    (31/65): perl-SelectSaver-1.02-481.1.el9_6.noarch.rpm                    87 kB/s |  10 kB     00:00
    (32/65): perl-AutoLoader-5.74-481.1.el9_6.noarch.rpm                     48 kB/s |  20 kB     00:00
    (33/65): perl-MIME-Base64-3.16-4.el9.x86_64.rpm                          69 kB/s |  30 kB     00:00
    (34/65): perl-IO-1.43-481.1.el9_6.x86_64.rpm                            433 kB/s |  85 kB     00:00
    (35/65): perl-if-0.60.800-481.1.el9_6.noarch.rpm                         57 kB/s |  13 kB     00:00
    (36/65): perl-overload-1.31-481.1.el9_6.noarch.rpm                      161 kB/s |  44 kB     00:00
    (37/65): perl-FileHandle-2.03-481.1.el9_6.noarch.rpm                    136 kB/s |  14 kB     00:00
    (38/65): perl-POSIX-1.94-481.1.el9_6.x86_64.rpm                         394 kB/s |  95 kB     00:00
    (39/65): perl-File-stat-1.09-481.1.el9_6.noarch.rpm                     220 kB/s |  16 kB     00:00
    (40/65): perl-File-Path-2.18-4.el9.noarch.rpm                           195 kB/s |  35 kB     00:00
    (41/65): perl-podlators-4.14-460.el9.noarch.rpm                         389 kB/s | 112 kB     00:00
    (42/65): perl-Symbol-1.08-481.1.el9_6.noarch.rpm                        176 kB/s |  13 kB     00:00
    (43/65): perl-Storable-3.21-460.el9.x86_64.rpm                          486 kB/s |  95 kB     00:00
    (44/65): perl-Data-Dumper-2.174-462.el9.x86_64.rpm                      248 kB/s |  55 kB     00:00
    (45/65): perl-File-Temp-0.231.100-4.el9.noarch.rpm                      416 kB/s |  59 kB     00:00
    (46/65): perl-Errno-1.30-481.1.el9_6.x86_64.rpm                         110 kB/s |  13 kB     00:00
    (47/65): perl-Digest-MD5-2.58-4.el9.x86_64.rpm                          409 kB/s |  36 kB     00:00
    (48/65): perl-Mozilla-CA-20200520-6.el9.noarch.rpm                      186 kB/s |  12 kB     00:00
    (49/65): perl-Term-ANSIColor-5.01-461.el9.noarch.rpm                    464 kB/s |  48 kB     00:00
    (50/65): perl-Pod-Usage-2.01-4.el9.noarch.rpm                           394 kB/s |  40 kB     00:00
    (51/65): perl-Class-Struct-0.66-481.1.el9_6.noarch.rpm                  219 kB/s |  21 kB     00:00
    (52/65): perl-Pod-Simple-3.42-4.el9.noarch.rpm                          352 kB/s | 215 kB     00:00
    (53/65): perl-IO-Socket-SSL-2.073-2.el9.noarch.rpm                      1.0 MB/s | 214 kB     00:00
    (54/65): perl-IPC-Open3-1.21-481.1.el9_6.noarch.rpm                     548 kB/s |  21 kB     00:00
    (55/65): perl-Carp-1.50-460.el9.noarch.rpm                              380 kB/s |  29 kB     00:00
    (56/65): perl-Time-Local-1.300-7.el9.noarch.rpm                         329 kB/s |  33 kB     00:00
    (57/65): perl-libnet-3.13-4.el9.noarch.rpm                              515 kB/s | 125 kB     00:00
    (58/65): perl-overloading-0.02-481.1.el9_6.noarch.rpm                    59 kB/s |  11 kB     00:00
    (59/65): perl-constant-1.33-461.el9.noarch.rpm                          292 kB/s |  23 kB     00:00
    (60/65): perl-Text-ParseWords-3.30-460.el9.noarch.rpm                   393 kB/s |  16 kB     00:00
    (61/65): perl-mro-1.23-481.1.el9_6.x86_64.rpm                           312 kB/s |  27 kB     00:00
    (62/65): perl-interpreter-5.32.1-481.1.el9_6.x86_64.rpm                 728 kB/s |  69 kB     00:00
    (63/65): perl-IO-Socket-IP-0.41-5.el9.noarch.rpm                        412 kB/s |  42 kB     00:00
    (64/65): perl-Encode-3.08-462.el9.x86_64.rpm                            1.8 MB/s | 1.7 MB     00:00
    (65/65): perl-libs-5.32.1-481.1.el9_6.x86_64.rpm                        507 kB/s | 2.0 MB     00:04
    --------------------------------------------------------------------------------------------------------
    Total                                                                   6.4 MB/s |  66 MB     00:10
    MySQL 8.0 Community Server                                              3.0 MB/s | 3.1 kB     00:00
    Importing GPG key 0xA8D3785C:
     Userid     : "MySQL Release Engineering <mysql-build@oss.oracle.com>"
     Fingerprint: BCA4 3417 C3B4 85DD 128E C6D4 B7B3 B788 A8D3 785C
     From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2023
    Key imported successfully
    MySQL 8.0 Community Server                                              3.0 MB/s | 3.1 kB     00:00
    Importing GPG key 0x3A79BD29:
     Userid     : "MySQL Release Engineering <mysql-build@oss.oracle.com>"
     Fingerprint: 859B E8D7 C586 F538 430B 19C2 467B 942D 3A79 BD29
     From       : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2022
    Key imported successfully
    Running transaction check
    Transaction check succeeded.
    Running transaction test
    Transaction test succeeded.
    Running transaction
      Preparing        :                                                                                1/1
      Installing       : perl-Digest-1.19-4.el9.noarch                                                 1/65
      Installing       : perl-Digest-MD5-2.58-4.el9.x86_64                                             2/65
      Installing       : perl-B-1.80-481.1.el9_6.x86_64                                                3/65
      Installing       : perl-FileHandle-2.03-481.1.el9_6.noarch                                       4/65
      Installing       : perl-Data-Dumper-2.174-462.el9.x86_64                                         5/65
      Installing       : perl-libnet-3.13-4.el9.noarch                                                 6/65
      Installing       : perl-base-2.27-481.1.el9_6.noarch                                             7/65
      Installing       : perl-AutoLoader-5.74-481.1.el9_6.noarch                                       8/65
      Installing       : perl-URI-5.09-3.el9.noarch                                                    9/65
      Installing       : perl-if-0.60.800-481.1.el9_6.noarch                                          10/65
      Installing       : perl-Pod-Escapes-1:1.07-460.el9.noarch                                       11/65
      Installing       : perl-Text-Tabs+Wrap-2013.0523-460.el9.noarch                                 12/65
      Installing       : perl-Net-SSLeay-1.94-1.el9.x86_64                                            13/65
      Installing       : perl-File-Path-2.18-4.el9.noarch                                             14/65
      Installing       : perl-Mozilla-CA-20200520-6.el9.noarch                                        15/65
      Installing       : perl-Time-Local-2:1.300-7.el9.noarch                                         16/65
      Installing       : perl-IO-Socket-SSL-2.073-2.el9.noarch                                        17/65
      Installing       : perl-IO-Socket-IP-0.41-5.el9.noarch                                          18/65
      Installing       : perl-subs-1.03-481.1.el9_6.noarch                                            19/65
      Installing       : perl-Term-Cap-1.17-460.el9.noarch                                            20/65
      Installing       : perl-Term-ANSIColor-5.01-461.el9.noarch                                      21/65
      Installing       : perl-POSIX-1.94-481.1.el9_6.x86_64                                           22/65
      Installing       : perl-Class-Struct-0.66-481.1.el9_6.noarch                                    23/65
      Installing       : perl-IPC-Open3-1.21-481.1.el9_6.noarch                                       24/65
      Installing       : perl-Pod-Simple-1:3.42-4.el9.noarch                                          25/65
      Installing       : perl-File-Temp-1:0.231.100-4.el9.noarch                                      26/65
      Installing       : perl-HTTP-Tiny-0.076-462.el9.noarch                                          27/65
      Installing       : perl-Socket-4:2.031-4.el9.x86_64                                             28/65
      Installing       : perl-Symbol-1.08-481.1.el9_6.noarch                                          29/65
      Installing       : perl-SelectSaver-1.02-481.1.el9_6.noarch                                     30/65
      Installing       : perl-File-stat-1.09-481.1.el9_6.noarch                                       31/65
      Installing       : perl-podlators-1:4.14-460.el9.noarch                                         32/65
      Installing       : perl-Pod-Perldoc-3.28.01-461.el9.noarch                                      33/65
      Installing       : perl-Fcntl-1.13-481.1.el9_6.x86_64                                           34/65
      Installing       : perl-overloading-0.02-481.1.el9_6.noarch                                     35/65
      Installing       : perl-Text-ParseWords-3.30-460.el9.noarch                                     36/65
      Installing       : perl-IO-1.43-481.1.el9_6.x86_64                                              37/65
      Installing       : perl-mro-1.23-481.1.el9_6.x86_64                                             38/65
      Installing       : perl-Pod-Usage-4:2.01-4.el9.noarch                                           39/65
      Installing       : perl-parent-1:0.238-460.el9.noarch                                           40/65
      Installing       : perl-vars-1.05-481.1.el9_6.noarch                                            41/65
      Installing       : perl-Scalar-List-Utils-4:1.56-462.el9.x86_64                                 42/65
      Installing       : perl-Getopt-Std-1.12-481.1.el9_6.noarch                                      43/65
      Installing       : perl-File-Basename-2.85-481.1.el9_6.noarch                                   44/65
      Installing       : perl-MIME-Base64-3.16-4.el9.x86_64                                           45/65
      Installing       : perl-Errno-1.30-481.1.el9_6.x86_64                                           46/65
      Installing       : perl-constant-1.33-461.el9.noarch                                            47/65
      Installing       : perl-Storable-1:3.21-460.el9.x86_64                                          48/65
      Installing       : perl-overload-1.31-481.1.el9_6.noarch                                        49/65
      Installing       : perl-Getopt-Long-1:2.52-4.el9.noarch                                         50/65
      Installing       : perl-NDBM_File-1.15-481.1.el9_6.x86_64                                       51/65
      Installing       : perl-Exporter-5.74-461.el9.noarch                                            52/65
      Installing       : perl-Carp-1.50-460.el9.noarch                                                53/65
      Installing       : perl-PathTools-3.78-461.el9.x86_64                                           54/65
      Installing       : perl-Encode-4:3.08-462.el9.x86_64                                            55/65
      Installing       : perl-libs-4:5.32.1-481.1.el9_6.x86_64                                        56/65
      Installing       : perl-interpreter-4:5.32.1-481.1.el9_6.x86_64                                 57/65
      Installing       : mysql-community-common-8.0.43-1.el9.x86_64                                   58/65
      Installing       : mysql-community-client-plugins-8.0.43-1.el9.x86_64                           59/65
      Installing       : mysql-community-libs-8.0.43-1.el9.x86_64                                     60/65
      Running scriptlet: mysql-community-libs-8.0.43-1.el9.x86_64                                     60/65
      Installing       : mysql-community-client-8.0.43-1.el9.x86_64                                   61/65
      Installing       : libtirpc-1.3.3-9.el9.x86_64                                                  62/65
      Installing       : net-tools-2.0-0.64.20160912git.el9.x86_64                                    63/65
      Running scriptlet: net-tools-2.0-0.64.20160912git.el9.x86_64                                    63/65
      Installing       : mysql-community-icu-data-files-8.0.43-1.el9.x86_64                           64/65
      Running scriptlet: mysql-community-server-8.0.43-1.el9.x86_64                                   65/65
      Installing       : mysql-community-server-8.0.43-1.el9.x86_64                                   65/65
      Running scriptlet: mysql-community-server-8.0.43-1.el9.x86_64                                   65/65
      Verifying        : mysql-community-client-8.0.43-1.el9.x86_64                                    1/65
      Verifying        : mysql-community-client-plugins-8.0.43-1.el9.x86_64                            2/65
      Verifying        : mysql-community-common-8.0.43-1.el9.x86_64                                    3/65
      Verifying        : mysql-community-icu-data-files-8.0.43-1.el9.x86_64                            4/65
      Verifying        : mysql-community-libs-8.0.43-1.el9.x86_64                                      5/65
      Verifying        : mysql-community-server-8.0.43-1.el9.x86_64                                    6/65
      Verifying        : net-tools-2.0-0.64.20160912git.el9.x86_64                                     7/65
      Verifying        : libtirpc-1.3.3-9.el9.x86_64                                                   8/65
      Verifying        : perl-Getopt-Long-1:2.52-4.el9.noarch                                          9/65
      Verifying        : perl-Term-Cap-1.17-460.el9.noarch                                            10/65
      Verifying        : perl-NDBM_File-1.15-481.1.el9_6.x86_64                                       11/65
      Verifying        : perl-Pod-Escapes-1:1.07-460.el9.noarch                                       12/65
      Verifying        : perl-vars-1.05-481.1.el9_6.noarch                                            13/65
      Verifying        : perl-Net-SSLeay-1.94-1.el9.x86_64                                            14/65
      Verifying        : perl-Socket-4:2.031-4.el9.x86_64                                             15/65
      Verifying        : perl-parent-1:0.238-460.el9.noarch                                           16/65
      Verifying        : perl-B-1.80-481.1.el9_6.x86_64                                               17/65
      Verifying        : perl-URI-5.09-3.el9.noarch                                                   18/65
      Verifying        : perl-Scalar-List-Utils-4:1.56-462.el9.x86_64                                 19/65
      Verifying        : perl-base-2.27-481.1.el9_6.noarch                                            20/65
      Verifying        : perl-Getopt-Std-1.12-481.1.el9_6.noarch                                      21/65
      Verifying        : perl-PathTools-3.78-461.el9.x86_64                                           22/65
      Verifying        : perl-Pod-Perldoc-3.28.01-461.el9.noarch                                      23/65
      Verifying        : perl-HTTP-Tiny-0.076-462.el9.noarch                                          24/65
      Verifying        : perl-Digest-1.19-4.el9.noarch                                                25/65
      Verifying        : perl-File-Basename-2.85-481.1.el9_6.noarch                                   26/65
      Verifying        : perl-Exporter-5.74-461.el9.noarch                                            27/65
      Verifying        : perl-subs-1.03-481.1.el9_6.noarch                                            28/65
      Verifying        : perl-MIME-Base64-3.16-4.el9.x86_64                                           29/65
      Verifying        : perl-AutoLoader-5.74-481.1.el9_6.noarch                                      30/65
      Verifying        : perl-Fcntl-1.13-481.1.el9_6.x86_64                                           31/65
      Verifying        : perl-Text-Tabs+Wrap-2013.0523-460.el9.noarch                                 32/65
      Verifying        : perl-SelectSaver-1.02-481.1.el9_6.noarch                                     33/65
      Verifying        : perl-IO-1.43-481.1.el9_6.x86_64                                              34/65
      Verifying        : perl-overload-1.31-481.1.el9_6.noarch                                        35/65
      Verifying        : perl-if-0.60.800-481.1.el9_6.noarch                                          36/65
      Verifying        : perl-POSIX-1.94-481.1.el9_6.x86_64                                           37/65
      Verifying        : perl-FileHandle-2.03-481.1.el9_6.noarch                                      38/65
      Verifying        : perl-podlators-1:4.14-460.el9.noarch                                         39/65
      Verifying        : perl-File-Path-2.18-4.el9.noarch                                             40/65
      Verifying        : perl-File-stat-1.09-481.1.el9_6.noarch                                       41/65
      Verifying        : perl-Storable-1:3.21-460.el9.x86_64                                          42/65
      Verifying        : perl-Symbol-1.08-481.1.el9_6.noarch                                          43/65
      Verifying        : perl-Data-Dumper-2.174-462.el9.x86_64                                        44/65
      Verifying        : perl-Pod-Simple-1:3.42-4.el9.noarch                                          45/65
      Verifying        : perl-File-Temp-1:0.231.100-4.el9.noarch                                      46/65
      Verifying        : perl-Errno-1.30-481.1.el9_6.x86_64                                           47/65
      Verifying        : perl-Digest-MD5-2.58-4.el9.x86_64                                            48/65
      Verifying        : perl-Term-ANSIColor-5.01-461.el9.noarch                                      49/65
      Verifying        : perl-Mozilla-CA-20200520-6.el9.noarch                                        50/65
      Verifying        : perl-Pod-Usage-4:2.01-4.el9.noarch                                           51/65
      Verifying        : perl-IO-Socket-SSL-2.073-2.el9.noarch                                        52/65
      Verifying        : perl-Class-Struct-0.66-481.1.el9_6.noarch                                    53/65
      Verifying        : perl-Carp-1.50-460.el9.noarch                                                54/65
      Verifying        : perl-Time-Local-2:1.300-7.el9.noarch                                         55/65
      Verifying        : perl-IPC-Open3-1.21-481.1.el9_6.noarch                                       56/65
      Verifying        : perl-libnet-3.13-4.el9.noarch                                                57/65
      Verifying        : perl-libs-4:5.32.1-481.1.el9_6.x86_64                                        58/65
      Verifying        : perl-Encode-4:3.08-462.el9.x86_64                                            59/65
      Verifying        : perl-overloading-0.02-481.1.el9_6.noarch                                     60/65
      Verifying        : perl-constant-1.33-461.el9.noarch                                            61/65
      Verifying        : perl-Text-ParseWords-3.30-460.el9.noarch                                     62/65
      Verifying        : perl-mro-1.23-481.1.el9_6.x86_64                                             63/65
      Verifying        : perl-interpreter-4:5.32.1-481.1.el9_6.x86_64                                 64/65
      Verifying        : perl-IO-Socket-IP-0.41-5.el9.noarch                                          65/65
    
    Installed:
      libtirpc-1.3.3-9.el9.x86_64                           mysql-community-client-8.0.43-1.el9.x86_64
      mysql-community-client-plugins-8.0.43-1.el9.x86_64    mysql-community-common-8.0.43-1.el9.x86_64
      mysql-community-icu-data-files-8.0.43-1.el9.x86_64    mysql-community-libs-8.0.43-1.el9.x86_64
      mysql-community-server-8.0.43-1.el9.x86_64            net-tools-2.0-0.64.20160912git.el9.x86_64
      perl-AutoLoader-5.74-481.1.el9_6.noarch               perl-B-1.80-481.1.el9_6.x86_64
      perl-Carp-1.50-460.el9.noarch                         perl-Class-Struct-0.66-481.1.el9_6.noarch
      perl-Data-Dumper-2.174-462.el9.x86_64                 perl-Digest-1.19-4.el9.noarch
      perl-Digest-MD5-2.58-4.el9.x86_64                     perl-Encode-4:3.08-462.el9.x86_64
      perl-Errno-1.30-481.1.el9_6.x86_64                    perl-Exporter-5.74-461.el9.noarch
      perl-Fcntl-1.13-481.1.el9_6.x86_64                    perl-File-Basename-2.85-481.1.el9_6.noarch
      perl-File-Path-2.18-4.el9.noarch                      perl-File-Temp-1:0.231.100-4.el9.noarch
      perl-File-stat-1.09-481.1.el9_6.noarch                perl-FileHandle-2.03-481.1.el9_6.noarch
      perl-Getopt-Long-1:2.52-4.el9.noarch                  perl-Getopt-Std-1.12-481.1.el9_6.noarch
      perl-HTTP-Tiny-0.076-462.el9.noarch                   perl-IO-1.43-481.1.el9_6.x86_64
      perl-IO-Socket-IP-0.41-5.el9.noarch                   perl-IO-Socket-SSL-2.073-2.el9.noarch
      perl-IPC-Open3-1.21-481.1.el9_6.noarch                perl-MIME-Base64-3.16-4.el9.x86_64
      perl-Mozilla-CA-20200520-6.el9.noarch                 perl-NDBM_File-1.15-481.1.el9_6.x86_64
      perl-Net-SSLeay-1.94-1.el9.x86_64                     perl-POSIX-1.94-481.1.el9_6.x86_64
      perl-PathTools-3.78-461.el9.x86_64                    perl-Pod-Escapes-1:1.07-460.el9.noarch
      perl-Pod-Perldoc-3.28.01-461.el9.noarch               perl-Pod-Simple-1:3.42-4.el9.noarch
      perl-Pod-Usage-4:2.01-4.el9.noarch                    perl-Scalar-List-Utils-4:1.56-462.el9.x86_64
      perl-SelectSaver-1.02-481.1.el9_6.noarch              perl-Socket-4:2.031-4.el9.x86_64
      perl-Storable-1:3.21-460.el9.x86_64                   perl-Symbol-1.08-481.1.el9_6.noarch
      perl-Term-ANSIColor-5.01-461.el9.noarch               perl-Term-Cap-1.17-460.el9.noarch
      perl-Text-ParseWords-3.30-460.el9.noarch              perl-Text-Tabs+Wrap-2013.0523-460.el9.noarch
      perl-Time-Local-2:1.300-7.el9.noarch                  perl-URI-5.09-3.el9.noarch
      perl-base-2.27-481.1.el9_6.noarch                     perl-constant-1.33-461.el9.noarch
      perl-if-0.60.800-481.1.el9_6.noarch                   perl-interpreter-4:5.32.1-481.1.el9_6.x86_64
      perl-libnet-3.13-4.el9.noarch                         perl-libs-4:5.32.1-481.1.el9_6.x86_64
      perl-mro-1.23-481.1.el9_6.x86_64                      perl-overload-1.31-481.1.el9_6.noarch
      perl-overloading-0.02-481.1.el9_6.noarch              perl-parent-1:0.238-460.el9.noarch
      perl-podlators-1:4.14-460.el9.noarch                  perl-subs-1.03-481.1.el9_6.noarch
      perl-vars-1.05-481.1.el9_6.noarch
    
    Complete!

faites un dnf search mysql pour voir les paquets dispos

       [kim@frontend ~]$ dnf search mysql
        
vous devriez voir un paquet mysql-community-server dispo
installez-le/ je l'ai vu et je l'installe avec: 

     [kim@frontend ~]$ dnf install -y mysql-community-server

#### 🌞 Démarrer le serveur MySQL

démarrer et activer le service MySQL au démarrage

        [root@frontend ~]# sudo systemctl enable --now mysqld
        

#### 🌞 Setup MySQL

un mot de passe temporaire pour l'utilisateur root de la base de données a été généré, il est visible dans /var/log/mysqld.log

    [root@frontend ~]# sudo grep 'temporary password' /var/log/mysqld.log
        
    2025-09-16T14:33:10.653619Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: %wxxxxxxxx

connectez-vous à la base pour y effectuer les commandes SQL suivantes :
    
    [root@frontend ~]# mysql -u root -p
    
    Enter password:
    Welcome to the MySQL monitor.  Commands end with ; or \g.
    Your MySQL connection id is 11
    Server version: 8.0.43
    
    Copyright (c) 2000, 2025, Oracle and/or its affiliates.
    
    Oracle is a registered trademark of Oracle Corporation and/or its
    affiliates. Other names may be trademarks of their respective
    owners.
    
    Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
    
    mysql> ALTER USER 'root'@'localhost' IDENTIFIED BY 'xxxxxxxxxxxxxxxxxxxx';
    Query OK, 0 rows affected (0.03 sec)
    
    mysql> CREATE USER 'xxxxxx' IDENTIFIED BY 'xxxxxxxxxxxxxxxxxxxx';
    Query OK, 0 rows affected (0.04 sec)
    
    mysql> CREATE DATABASE xxxxxxxx;
    Query OK, 1 row affected (0.01 sec)
    
    mysql> GRANT ALL PRIVILEGES ON opennebula.* TO 'xxxxxxxxx';
    Query OK, 0 rows affected (0.01 sec)
    
    mysql> SET GLOBAL TRANSACTION ISOLATION LEVEL READ COMMITTED;
    Query OK, 0 rows affected (0.00 sec)

### B. OpenNebula¶
#### 🌞 Ajouter les dépôts Open Nebula

ajoutez le dépôt suivant à la liste de dépôts de votre machine

#### 🌞 Installer OpenNebula
installez les paquets opennebula, opennebula-sunstone, opennebula-fireedge

    [root@frontend ~]# sudo dnf install -y opennebula opennebula-sunstone opennebula-fireedge
    
    Last metadata expiration check: 0:00:37 ago on Tue Sep 16 20:31:02 2025.
    Dependencies resolved.
    ==================================================================================================
     Package                     Arch     Version                                  Repository    Size
    ==================================================================================================
    Installing:
     opennebula                  x86_64   6.10.0.1-1.el9                           opennebula    10 M
     opennebula-fireedge         x86_64   6.10.0.1-1.el9                           opennebula    46 M
     opennebula-sunstone         noarch   6.10.0.1-1.el9                           opennebula    29 M
    Installing dependencies:
     augeas-libs                 x86_64   1.14.1-2.el9                             appstream    373 k
     flexiblas                   x86_64   3.0.4-8.el9.0.1                          appstream     30 k
     flexiblas-netlib            x86_64   3.0.4-8.el9.0.1                          appstream    3.0 M
     flexiblas-openblas-openmp   x86_64   3.0.4-8.el9.0.1                          appstream     15 k
     freerdp-libs                x86_64   2:2.11.7-1.el9                           appstream    900 k
     genisoimage                 x86_64   1.1.11-48.el9                            epel         324 k
     glx-utils                   x86_64   8.4.0-12.20210504git0f9e7d9.el9.0.1      appstream     40 k
     gnuplot-common              x86_64   5.4.3-2.el9                              epel         776 k
     lame-libs                   x86_64   3.100-12.el9                             appstream    332 k
     libcerf                     x86_64   1.17-2.el9                               epel          38 k
     libevdev                    x86_64   1.11.0-3.el9                             appstream     45 k
     libgfortran                 x86_64   11.5.0-5.el9_5                           baseos       797 k
     libinput                    x86_64   1.19.3-5.el9_6                           appstream    193 k
     libquadmath                 x86_64   11.5.0-5.el9_5                           baseos       187 k
     libssh2                     x86_64   1.11.0-1.el9                             epel         132 k
     liburing                    x86_64   2.5-1.el9                                appstream     38 k
     libusal                     x86_64   1.1.11-48.el9                            epel         137 k
     libvncserver                x86_64   0.9.13-11.el9                            epel         296 k
     libwacom                    x86_64   1.12.1-3.el9_4                           appstream     43 k
     libwacom-data               noarch   1.12.1-3.el9_4                           appstream    105 k
     libwinpr                    x86_64   2:2.11.7-1.el9                           appstream    356 k
     libxkbcommon-x11            x86_64   1.0.3-4.el9                              appstream     21 k
     libxkbfile                  x86_64   1.1.0-8.el9                              appstream     88 k
     mtdev                       x86_64   1.1.5-22.el9                             appstream     21 k
     nodejs                      x86_64   1:16.20.2-8.el9_4                        appstream    111 k
     nodejs-libs                 x86_64   1:16.20.2-8.el9_4                        appstream     15 M
     openblas                    x86_64   0.3.26-2.el9                             appstream     37 k
     openblas-openmp             x86_64   0.3.26-2.el9                             appstream    4.9 M
     opennebula-common           noarch   6.10.0.1-1.el9                           opennebula    23 k
     opennebula-common-onecfg    noarch   6.10.0.1-1.el9                           opennebula   9.1 k
     opennebula-libs             noarch   6.10.0.1-1.el9                           opennebula   202 k
     opennebula-provision-data   noarch   6.10.0.1-1.el9                           opennebula    52 k
     opennebula-rubygems         x86_64   6.10.0.1-1.el9                           opennebula    16 M
     opennebula-tools            noarch   6.10.0.1-1.el9                           opennebula   191 k
     python3-numpy               x86_64   1:1.23.5-1.el9                           appstream    5.8 M
     qemu-img                    x86_64   17:9.1.0-15.el9_6.7                      appstream    2.5 M
     qt5-qtbase                  x86_64   5.15.9-11.el9_6                          appstream    3.5 M
     qt5-qtbase-common           noarch   5.15.9-11.el9_6                          appstream    7.6 k
     qt5-qtbase-gui              x86_64   5.15.9-11.el9_6                          appstream    6.3 M
     qt5-qtsvg                   x86_64   5.15.9-2.el9                             appstream    184 k
     rsync                       x86_64   3.2.5-3.el9                              baseos       403 k
     rubygem-rexml               noarch   3.2.5-165.el9_5                          appstream     92 k
     uuid                        x86_64   1.6.2-55.el9                             appstream     56 k
     xcb-util                    x86_64   0.4.0-19.el9                             appstream     18 k
     xcb-util-image              x86_64   0.4.0-19.el9.0.1                         appstream     18 k
     xcb-util-keysyms            x86_64   0.4.0-17.el9                             appstream     14 k
     xcb-util-renderutil         x86_64   0.3.9-20.el9.0.1                         appstream     16 k
     xcb-util-wm                 x86_64   0.4.1-22.el9                             appstream     31 k
     xmlrpc-c                    x86_64   1.51.0-16.el9                            appstream    140 k
    Installing weak dependencies:
     bash-completion             noarch   1:2.11-5.el9                             baseos       291 k
     gnuplot                     x86_64   5.4.3-2.el9                              epel         820 k
     nodejs-docs                 noarch   1:16.20.2-8.el9_4                        appstream    7.1 M
     nodejs-full-i18n            x86_64   1:16.20.2-8.el9_4                        appstream    8.2 M
     npm                         x86_64   1:8.19.4-1.16.20.2.8.el9_4               appstream    1.7 M
     opennebula-guacd            x86_64   6.10.0.1-1.2.0+1.el9                     opennebula   220 k
    
    Transaction Summary
    ==================================================================================================
    Install  58 Packages
    
    Total download size: 166 M
    Installed size: 989 M
    Downloading Packages:
    (1/58): gnuplot-5.4.3-2.el9.x86_64.rpm                            1.9 MB/s | 820 kB     00:00
    (2/58): libcerf-1.17-2.el9.x86_64.rpm                             619 kB/s |  38 kB     00:00
    (3/58): libssh2-1.11.0-1.el9.x86_64.rpm                           2.0 MB/s | 132 kB     00:00
    (4/58): genisoimage-1.1.11-48.el9.x86_64.rpm                      563 kB/s | 324 kB     00:00
    (5/58): gnuplot-common-5.4.3-2.el9.x86_64.rpm                     1.2 MB/s | 776 kB     00:00
    (6/58): libusal-1.1.11-48.el9.x86_64.rpm                          1.1 MB/s | 137 kB     00:00
    (7/58): libvncserver-0.9.13-11.el9.x86_64.rpm                     2.5 MB/s | 296 kB     00:00
    (8/58): opennebula-common-6.10.0.1-1.el9.noarch.rpm               118 kB/s |  23 kB     00:00
    (9/58): opennebula-common-onecfg-6.10.0.1-1.el9.noarch.rpm         54 kB/s | 9.1 kB     00:00
    (10/58): opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64.rpm         828 kB/s | 220 kB     00:00
    (11/58): opennebula-libs-6.10.0.1-1.el9.noarch.rpm                871 kB/s | 202 kB     00:00
    (12/58): opennebula-6.10.0.1-1.el9.x86_64.rpm                      11 MB/s |  10 MB     00:00
    (13/58): opennebula-provision-data-6.10.0.1-1.el9.noarch.rpm      363 kB/s |  52 kB     00:00
    (14/58): opennebula-rubygems-6.10.0.1-1.el9.x86_64.rpm             14 MB/s |  16 MB     00:01
    (15/58): opennebula-tools-6.10.0.1-1.el9.noarch.rpm               693 kB/s | 191 kB     00:00
    (16/58): opennebula-fireedge-6.10.0.1-1.el9.x86_64.rpm             13 MB/s |  46 MB     00:03
    (17/58): bash-completion-2.11-5.el9.noarch.rpm                    193 kB/s | 291 kB     00:01
    (18/58): libquadmath-11.5.0-5.el9_5.x86_64.rpm                    486 kB/s | 187 kB     00:00
    (19/58): rsync-3.2.5-3.el9.x86_64.rpm                             851 kB/s | 403 kB     00:00
    (20/58): flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64.rpm      62 kB/s |  15 kB     00:00
    (21/58): libgfortran-11.5.0-5.el9_5.x86_64.rpm                    1.4 MB/s | 797 kB     00:00
    (22/58): libwinpr-2.11.7-1.el9.x86_64.rpm                         313 kB/s | 356 kB     00:01
    (23/58): opennebula-sunstone-6.10.0.1-1.el9.noarch.rpm            4.8 MB/s |  29 MB     00:05
    (24/58): nodejs-docs-16.20.2-8.el9_4.noarch.rpm                   1.9 MB/s | 7.1 MB     00:03
    (25/58): qt5-qtbase-common-5.15.9-11.el9_6.noarch.rpm             2.9 kB/s | 7.6 kB     00:02
    (26/58): nodejs-libs-16.20.2-8.el9_4.x86_64.rpm                   4.4 MB/s |  15 MB     00:03
    (27/58): xcb-util-wm-0.4.1-22.el9.x86_64.rpm                       17 kB/s |  31 kB     00:01
    (28/58): python3-numpy-1.23.5-1.el9.x86_64.rpm                    2.4 MB/s | 5.8 MB     00:02
    (29/58): xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64.rpm           26 kB/s |  16 kB     00:00
    (30/58): augeas-libs-1.14.1-2.el9.x86_64.rpm                      575 kB/s | 373 kB     00:00
    (31/58): glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64.rpm 710 kB/s |  40 kB     00:00
    (32/58): liburing-2.5-1.el9.x86_64.rpm                            459 kB/s |  38 kB     00:00
    (33/58): libinput-1.19.3-5.el9_6.x86_64.rpm                       2.2 MB/s | 193 kB     00:00
    (34/58): flexiblas-3.0.4-8.el9.0.1.x86_64.rpm                     670 kB/s |  30 kB     00:00
    (35/58): openblas-openmp-0.3.26-2.el9.x86_64.rpm                  5.4 MB/s | 4.9 MB     00:00
    (36/58): flexiblas-netlib-3.0.4-8.el9.0.1.x86_64.rpm              3.1 MB/s | 3.0 MB     00:00
    (37/58): nodejs-full-i18n-16.20.2-8.el9_4.x86_64.rpm              5.6 MB/s | 8.2 MB     00:01
    (38/58): openblas-0.3.26-2.el9.x86_64.rpm                          60 kB/s |  37 kB     00:00
    (39/58): npm-8.19.4-1.16.20.2.8.el9_4.x86_64.rpm                  2.9 MB/s | 1.7 MB     00:00
    (40/58): freerdp-libs-2.11.7-1.el9.x86_64.rpm                      10 MB/s | 900 kB     00:00
    (41/58): libevdev-1.11.0-3.el9.x86_64.rpm                         525 kB/s |  45 kB     00:00
    (42/58): xcb-util-0.4.0-19.el9.x86_64.rpm                         403 kB/s |  18 kB     00:00
    (43/58): libxkbcommon-x11-1.0.3-4.el9.x86_64.rpm                  488 kB/s |  21 kB     00:00
    (44/58): uuid-1.6.2-55.el9.x86_64.rpm                             1.1 MB/s |  56 kB     00:00
    (45/58): xmlrpc-c-1.51.0-16.el9.x86_64.rpm                        2.1 MB/s | 140 kB     00:00
    (46/58): libwacom-data-1.12.1-3.el9_4.noarch.rpm                  2.0 MB/s | 105 kB     00:00
    (47/58): libwacom-1.12.1-3.el9_4.x86_64.rpm                       527 kB/s |  43 kB     00:00
    (48/58): xcb-util-keysyms-0.4.0-17.el9.x86_64.rpm                 177 kB/s |  14 kB     00:00
    (49/58): qemu-img-9.1.0-15.el9_6.7.x86_64.rpm                     9.8 MB/s | 2.5 MB     00:00
    (50/58): rubygem-rexml-3.2.5-165.el9_5.noarch.rpm                 1.5 MB/s |  92 kB     00:00
    (51/58): nodejs-16.20.2-8.el9_4.x86_64.rpm                        2.0 MB/s | 111 kB     00:00
    (52/58): mtdev-1.1.5-22.el9.x86_64.rpm                            349 kB/s |  21 kB     00:00
    (53/58): xcb-util-image-0.4.0-19.el9.0.1.x86_64.rpm               151 kB/s |  18 kB     00:00
    (54/58): qt5-qtbase-5.15.9-11.el9_6.x86_64.rpm                    6.1 MB/s | 3.5 MB     00:00
    (55/58): qt5-qtsvg-5.15.9-2.el9.x86_64.rpm                        519 kB/s | 184 kB     00:00
    (56/58): qt5-qtbase-gui-5.15.9-11.el9_6.x86_64.rpm                6.7 MB/s | 6.3 MB     00:00
    (57/58): libxkbfile-1.1.0-8.el9.x86_64.rpm                        1.2 MB/s |  88 kB     00:00
    (58/58): lame-libs-3.100-12.el9.x86_64.rpm                        4.7 MB/s | 332 kB     00:00
    --------------------------------------------------------------------------------------------------
    Total                                                              11 MB/s | 166 MB     00:15
    OpenNebula Community Edition                                       10 kB/s | 3.1 kB     00:00
    Importing GPG key 0x906DC27C:
     Userid     : "OpenNebula Repository <contact@opennebula.io>"
     Fingerprint: 0B2D 385C 7C93 04B1 1A03 67B9 05A0 5927 906D C27C
     From       : https://downloads.opennebula.io/repo/repo2.key
    Key imported successfully
    Running transaction check
    Transaction check succeeded.
    Running transaction test
    Transaction test succeeded.
    Running transaction
      Running scriptlet: npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64                                    1/1
      Preparing        :                                                                          1/1
      Running scriptlet: opennebula-common-onecfg-6.10.0.1-1.el9.noarch                          1/58
      Installing       : opennebula-common-onecfg-6.10.0.1-1.el9.noarch                          1/58
      Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch                                 2/58
      Installing       : opennebula-common-6.10.0.1-1.el9.noarch                                 2/58
      Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch                                 2/58
      Installing       : flexiblas-3.0.4-8.el9.0.1.x86_64                                        3/58
      Installing       : augeas-libs-1.14.1-2.el9.x86_64                                         4/58
      Installing       : opennebula-rubygems-6.10.0.1-1.el9.x86_64                               5/58
      Running scriptlet: opennebula-rubygems-6.10.0.1-1.el9.x86_64                               5/58
      Installing       : libwinpr-2:2.11.7-1.el9.x86_64                                          6/58
      Installing       : libquadmath-11.5.0-5.el9_5.x86_64                                       7/58
      Installing       : libgfortran-11.5.0-5.el9_5.x86_64                                       8/58
      Running scriptlet: qt5-qtbase-5.15.9-11.el9_6.x86_64                                       9/58
      Installing       : qt5-qtbase-5.15.9-11.el9_6.x86_64                                       9/58
      Running scriptlet: qt5-qtbase-5.15.9-11.el9_6.x86_64                                       9/58
      Installing       : qt5-qtbase-common-5.15.9-11.el9_6.noarch                               10/58
      Installing       : lame-libs-3.100-12.el9.x86_64                                          11/58
      Installing       : libxkbfile-1.1.0-8.el9.x86_64                                          12/58
      Installing       : freerdp-libs-2:2.11.7-1.el9.x86_64                                     13/58
      Installing       : mtdev-1.1.5-22.el9.x86_64                                              14/58
      Installing       : rubygem-rexml-3.2.5-165.el9_5.noarch                                   15/58
      Installing       : opennebula-libs-6.10.0.1-1.el9.noarch                                  16/58
      Running scriptlet: opennebula-libs-6.10.0.1-1.el9.noarch                                  16/58
      Installing       : xcb-util-keysyms-0.4.0-17.el9.x86_64                                   17/58
      Installing       : libwacom-data-1.12.1-3.el9_4.noarch                                    18/58
      Installing       : libwacom-1.12.1-3.el9_4.x86_64                                         19/58
      Installing       : xmlrpc-c-1.51.0-16.el9.x86_64                                          20/58
      Installing       : libxkbcommon-x11-1.0.3-4.el9.x86_64                                    21/58
      Installing       : uuid-1.6.2-55.el9.x86_64                                               22/58
      Installing       : xcb-util-0.4.0-19.el9.x86_64                                           23/58
      Installing       : xcb-util-image-0.4.0-19.el9.0.1.x86_64                                 24/58
      Installing       : libevdev-1.11.0-3.el9.x86_64                                           25/58
      Installing       : libinput-1.19.3-5.el9_6.x86_64                                         26/58
      Running scriptlet: libinput-1.19.3-5.el9_6.x86_64                                         26/58
      Installing       : openblas-0.3.26-2.el9.x86_64                                           27/58
      Installing       : openblas-openmp-0.3.26-2.el9.x86_64                                    28/58
      Installing       : flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64                       29/58
      Installing       : flexiblas-netlib-3.0.4-8.el9.0.1.x86_64                                30/58
      Installing       : python3-numpy-1:1.23.5-1.el9.x86_64                                    31/58
      Installing       : glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64                   32/58
      Installing       : liburing-2.5-1.el9.x86_64                                              33/58
      Installing       : qemu-img-17:9.1.0-15.el9_6.7.x86_64                                    34/58
      Installing       : xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64                            35/58
      Installing       : xcb-util-wm-0.4.1-22.el9.x86_64                                        36/58
      Installing       : qt5-qtbase-gui-5.15.9-11.el9_6.x86_64                                  37/58
      Installing       : qt5-qtsvg-5.15.9-2.el9.x86_64                                          38/58
      Installing       : nodejs-libs-1:16.20.2-8.el9_4.x86_64                                   39/58
      Installing       : nodejs-docs-1:16.20.2-8.el9_4.noarch                                   40/58
      Installing       : nodejs-full-i18n-1:16.20.2-8.el9_4.x86_64                              41/58
      Installing       : nodejs-1:16.20.2-8.el9_4.x86_64                                        42/58
      Installing       : npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64                                  43/58
      Installing       : rsync-3.2.5-3.el9.x86_64                                               44/58
      Installing       : bash-completion-1:2.11-5.el9.noarch                                    45/58
      Installing       : opennebula-provision-data-6.10.0.1-1.el9.noarch                        46/58
      Installing       : libvncserver-0.9.13-11.el9.x86_64                                      47/58
      Installing       : libusal-1.1.11-48.el9.x86_64                                           48/58
      Installing       : genisoimage-1.1.11-48.el9.x86_64                                       49/58
      Running scriptlet: genisoimage-1.1.11-48.el9.x86_64                                       49/58
      Installing       : libssh2-1.11.0-1.el9.x86_64                                            50/58
      Running scriptlet: opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                           51/58
      Installing       : opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                           51/58
      Running scriptlet: opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                           51/58
      Installing       : libcerf-1.17-2.el9.x86_64                                              52/58
      Installing       : gnuplot-common-5.4.3-2.el9.x86_64                                      53/58
      Installing       : gnuplot-5.4.3-2.el9.x86_64                                             54/58
      Installing       : opennebula-tools-6.10.0.1-1.el9.noarch                                 55/58
      Running scriptlet: opennebula-6.10.0.1-1.el9.x86_64                                       56/58
      Installing       : opennebula-6.10.0.1-1.el9.x86_64                                       56/58
      Running scriptlet: opennebula-6.10.0.1-1.el9.x86_64                                       56/58
    Generating public/private rsa key pair.
    Your identification has been saved in /var/lib/one/.ssh/id_rsa
    Your public key has been saved in /var/lib/one/.ssh/id_rsa.pub
    The key fingerprint is:
    SHA256:tXUiRA4/75P4aaF2LRkdd8a8KHN7lfg4nO2ccsE+9AA oneadmin@frontend.one
    The key's randomart image is:
    +---[RSA 3072]----+
    |        ..o      |
    |         =       |
    |          * o .o |
    |         . *Eo. *|
    |        S . .o+++|
    |           =o=o*.|
    |          ..O=O.+|
    |          o.=XoBo|
    |         . oo.*+.|
    +----[SHA256]-----+
    
      Running scriptlet: opennebula-sunstone-6.10.0.1-1.el9.noarch                              57/58
      Installing       : opennebula-sunstone-6.10.0.1-1.el9.noarch                              57/58
      Running scriptlet: opennebula-sunstone-6.10.0.1-1.el9.noarch                              57/58
      Running scriptlet: opennebula-fireedge-6.10.0.1-1.el9.x86_64                              58/58
      Installing       : opennebula-fireedge-6.10.0.1-1.el9.x86_64                              58/58
      Running scriptlet: opennebula-fireedge-6.10.0.1-1.el9.x86_64                              58/58
      Running scriptlet: gnuplot-5.4.3-2.el9.x86_64                                             58/58
      Running scriptlet: opennebula-fireedge-6.10.0.1-1.el9.x86_64                              58/58
      Verifying        : genisoimage-1.1.11-48.el9.x86_64                                        1/58
      Verifying        : gnuplot-5.4.3-2.el9.x86_64                                              2/58
      Verifying        : gnuplot-common-5.4.3-2.el9.x86_64                                       3/58
      Verifying        : libcerf-1.17-2.el9.x86_64                                               4/58
      Verifying        : libssh2-1.11.0-1.el9.x86_64                                             5/58
      Verifying        : libusal-1.1.11-48.el9.x86_64                                            6/58
      Verifying        : libvncserver-0.9.13-11.el9.x86_64                                       7/58
      Verifying        : opennebula-6.10.0.1-1.el9.x86_64                                        8/58
      Verifying        : opennebula-common-6.10.0.1-1.el9.noarch                                 9/58
      Verifying        : opennebula-common-onecfg-6.10.0.1-1.el9.noarch                         10/58
      Verifying        : opennebula-fireedge-6.10.0.1-1.el9.x86_64                              11/58
      Verifying        : opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64                           12/58
      Verifying        : opennebula-libs-6.10.0.1-1.el9.noarch                                  13/58
      Verifying        : opennebula-provision-data-6.10.0.1-1.el9.noarch                        14/58
      Verifying        : opennebula-rubygems-6.10.0.1-1.el9.x86_64                              15/58
      Verifying        : opennebula-sunstone-6.10.0.1-1.el9.noarch                              16/58
      Verifying        : opennebula-tools-6.10.0.1-1.el9.noarch                                 17/58
      Verifying        : bash-completion-1:2.11-5.el9.noarch                                    18/58
      Verifying        : libquadmath-11.5.0-5.el9_5.x86_64                                      19/58
      Verifying        : rsync-3.2.5-3.el9.x86_64                                               20/58
      Verifying        : libgfortran-11.5.0-5.el9_5.x86_64                                      21/58
      Verifying        : flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64                       22/58
      Verifying        : libwinpr-2:2.11.7-1.el9.x86_64                                         23/58
      Verifying        : nodejs-docs-1:16.20.2-8.el9_4.noarch                                   24/58
      Verifying        : qt5-qtbase-common-5.15.9-11.el9_6.noarch                               25/58
      Verifying        : nodejs-libs-1:16.20.2-8.el9_4.x86_64                                   26/58
      Verifying        : xcb-util-wm-0.4.1-22.el9.x86_64                                        27/58
      Verifying        : python3-numpy-1:1.23.5-1.el9.x86_64                                    28/58
      Verifying        : augeas-libs-1.14.1-2.el9.x86_64                                        29/58
      Verifying        : xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64                            30/58
      Verifying        : liburing-2.5-1.el9.x86_64                                              31/58
      Verifying        : libinput-1.19.3-5.el9_6.x86_64                                         32/58
      Verifying        : glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64                   33/58
      Verifying        : openblas-openmp-0.3.26-2.el9.x86_64                                    34/58
      Verifying        : flexiblas-3.0.4-8.el9.0.1.x86_64                                       35/58
      Verifying        : flexiblas-netlib-3.0.4-8.el9.0.1.x86_64                                36/58
      Verifying        : nodejs-full-i18n-1:16.20.2-8.el9_4.x86_64                              37/58
      Verifying        : openblas-0.3.26-2.el9.x86_64                                           38/58
      Verifying        : npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64                                  39/58
      Verifying        : freerdp-libs-2:2.11.7-1.el9.x86_64                                     40/58
      Verifying        : libevdev-1.11.0-3.el9.x86_64                                           41/58
      Verifying        : xcb-util-0.4.0-19.el9.x86_64                                           42/58
      Verifying        : uuid-1.6.2-55.el9.x86_64                                               43/58
      Verifying        : libxkbcommon-x11-1.0.3-4.el9.x86_64                                    44/58
      Verifying        : xmlrpc-c-1.51.0-16.el9.x86_64                                          45/58
      Verifying        : qt5-qtbase-gui-5.15.9-11.el9_6.x86_64                                  46/58
      Verifying        : libwacom-data-1.12.1-3.el9_4.noarch                                    47/58
      Verifying        : qemu-img-17:9.1.0-15.el9_6.7.x86_64                                    48/58
      Verifying        : libwacom-1.12.1-3.el9_4.x86_64                                         49/58
      Verifying        : xcb-util-keysyms-0.4.0-17.el9.x86_64                                   50/58
      Verifying        : rubygem-rexml-3.2.5-165.el9_5.noarch                                   51/58
      Verifying        : qt5-qtbase-5.15.9-11.el9_6.x86_64                                      52/58
      Verifying        : nodejs-1:16.20.2-8.el9_4.x86_64                                        53/58
      Verifying        : mtdev-1.1.5-22.el9.x86_64                                              54/58
      Verifying        : xcb-util-image-0.4.0-19.el9.0.1.x86_64                                 55/58
      Verifying        : qt5-qtsvg-5.15.9-2.el9.x86_64                                          56/58
      Verifying        : libxkbfile-1.1.0-8.el9.x86_64                                          57/58
      Verifying        : lame-libs-3.100-12.el9.x86_64                                          58/58
    
    Installed:
      augeas-libs-1.14.1-2.el9.x86_64
      bash-completion-1:2.11-5.el9.noarch
      flexiblas-3.0.4-8.el9.0.1.x86_64
      flexiblas-netlib-3.0.4-8.el9.0.1.x86_64
      flexiblas-openblas-openmp-3.0.4-8.el9.0.1.x86_64
      freerdp-libs-2:2.11.7-1.el9.x86_64
      genisoimage-1.1.11-48.el9.x86_64
      glx-utils-8.4.0-12.20210504git0f9e7d9.el9.0.1.x86_64
      gnuplot-5.4.3-2.el9.x86_64
      gnuplot-common-5.4.3-2.el9.x86_64
      lame-libs-3.100-12.el9.x86_64
      libcerf-1.17-2.el9.x86_64
      libevdev-1.11.0-3.el9.x86_64
      libgfortran-11.5.0-5.el9_5.x86_64
      libinput-1.19.3-5.el9_6.x86_64
      libquadmath-11.5.0-5.el9_5.x86_64
      libssh2-1.11.0-1.el9.x86_64
      liburing-2.5-1.el9.x86_64
      libusal-1.1.11-48.el9.x86_64
      libvncserver-0.9.13-11.el9.x86_64
      libwacom-1.12.1-3.el9_4.x86_64
      libwacom-data-1.12.1-3.el9_4.noarch
      libwinpr-2:2.11.7-1.el9.x86_64
      libxkbcommon-x11-1.0.3-4.el9.x86_64
      libxkbfile-1.1.0-8.el9.x86_64
      mtdev-1.1.5-22.el9.x86_64
      nodejs-1:16.20.2-8.el9_4.x86_64
      nodejs-docs-1:16.20.2-8.el9_4.noarch
      nodejs-full-i18n-1:16.20.2-8.el9_4.x86_64
      nodejs-libs-1:16.20.2-8.el9_4.x86_64
      npm-1:8.19.4-1.16.20.2.8.el9_4.x86_64
      openblas-0.3.26-2.el9.x86_64
      openblas-openmp-0.3.26-2.el9.x86_64
      opennebula-6.10.0.1-1.el9.x86_64
      opennebula-common-6.10.0.1-1.el9.noarch
      opennebula-common-onecfg-6.10.0.1-1.el9.noarch
      opennebula-fireedge-6.10.0.1-1.el9.x86_64
      opennebula-guacd-6.10.0.1-1.2.0+1.el9.x86_64
      opennebula-libs-6.10.0.1-1.el9.noarch
      opennebula-provision-data-6.10.0.1-1.el9.noarch
      opennebula-rubygems-6.10.0.1-1.el9.x86_64
      opennebula-sunstone-6.10.0.1-1.el9.noarch
      opennebula-tools-6.10.0.1-1.el9.noarch
      python3-numpy-1:1.23.5-1.el9.x86_64
      qemu-img-17:9.1.0-15.el9_6.7.x86_64
      qt5-qtbase-5.15.9-11.el9_6.x86_64
      qt5-qtbase-common-5.15.9-11.el9_6.noarch
      qt5-qtbase-gui-5.15.9-11.el9_6.x86_64
      qt5-qtsvg-5.15.9-2.el9.x86_64
      rsync-3.2.5-3.el9.x86_64
      rubygem-rexml-3.2.5-165.el9_5.noarch
      uuid-1.6.2-55.el9.x86_64
      xcb-util-0.4.0-19.el9.x86_64
      xcb-util-image-0.4.0-19.el9.0.1.x86_64
      xcb-util-keysyms-0.4.0-17.el9.x86_64
      xcb-util-renderutil-0.3.9-20.el9.0.1.x86_64
      xcb-util-wm-0.4.1-22.el9.x86_64
      xmlrpc-c-1.51.0-16.el9.x86_64
    
    Complete!

#### 🌞 Configuration OpenNebula

dans le fichier /etc/one/oned.conf, Je définis correctement les paramètres de connexion à la base de données, je remplace la clause DB = par

          DB = [ BACKEND = "mysql",
                 SERVER  = "localhost",
                 PORT    = 0,
                 USER    = "oneadmin",
                 PASSWD  = "also_here_define_another_strong_password",
                 DB_NAME = "opennebula",
                 CONNECTIONS = 25,
                 COMPARE_BINARY = "no" ]
                 
#### 🌞 Créer un user pour se log sur la WebUI OpenNebula

pour ça, il faut se log en tant que l'utilisateur oneadmin sur le serveur
une fois connecté en tant que oneadmin, inscrivez le user oneadmin et le password de votre choix dans le fichier /var/lib/one/.one/one_auth sous la forme user:password
Par exemple : vous stockez la chaîne oneadmin:super_password dans le fichier.

    [root@frontend ~]# sudo vim /etc/one/oned.conf
    [root@frontend ~]# sudo su - oneadmin
    Last login: Tue Sep 16 20:33:54 CEST 2025
    [oneadmin@frontend ~]$ echo "oneadmin:MyWebUIPassword123!" > /var/lib/one/.one/one_auth


#### 🌞 Démarrer les services OpenNebula

démarrez les services opennebula, opennebula-sunstone
activez-les aussi au démarrage de la machine

        [oneadmin@frontend ~]$ sudo systemctl enable --now opennebula opennebula-sunstone
        [sudo] password for oneadmin:
        Created symlink /etc/systemd/system/multi-user.target.wants/opennebula.service → /usr/lib/systemd/system/opennebula.service.
        Created symlink /etc/systemd/system/multi-user.target.wants/opennebula-sunstone.service → /usr/lib/systemd/system/opennebula-sunstone.service.

### C. Conf système

#### 🌞 Ouverture firewall

ouvrez les ports suivants, avec des commandes firewall-cmd :

    [oneadmin@frontend ~]$ sudo firewall-cmd --permanent --add-port=9869/tcp
    success
    [oneadmin@frontend ~]$ sudo firewall-cmd --permanent --add-port=22/tcp
    success
    [oneadmin@frontend ~]$ sudo firewall-cmd --permanent --add-port=2633/tcp
    success
    [oneadmin@frontend ~]$ sudo firewall-cmd --permanent --add-port=4124/tcp
    success
    [oneadmin@frontend ~]$ sudo firewall-cmd --permanent --add-port=4124/udp
    success
    [oneadmin@frontend ~]$ sudo firewall-cmd --permanent --add-port=29876/tcp
    success
    [oneadmin@frontend ~]$ sudo firewall-cmd --reload
    success



### II.2. Noeuds KVM


### A. KVM
#### 🌞 Ajouter des dépôts supplémentaires

ajoutez les dépôts de OpenNebula, les mêmes que pour le Frontend !

juste les dépôts, n'installez pas les paquets OpenNebula
ajoutez aussi les dépôts du serveur MySQL communautaire


    [root@kvm1 ~]# wget https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
    
    --2025-09-16 22:05:50--  https://dev.mysql.com/get/mysql80-community-release-el9-5.noarch.rpm
    Résolution de dev.mysql.com (dev.mysql.com)… 104.85.37.194, 2a02:26f0:2b80:f8d::2e31, 2a02:26f0:2b80:f95::2e31
    Connexion à dev.mysql.com (dev.mysql.com)|104.85.37.194|:443… connecté.
    requête HTTP transmise, en attente de la réponse… 302 Moved Temporarily
    Emplacement : https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm [suivant]
    --2025-09-16 22:05:51--  https://repo.mysql.com//mysql80-community-release-el9-5.noarch.rpm
    Résolution de repo.mysql.com (repo.mysql.com)… 104.85.20.87, 2a02:26f0:9100:184::1d68, 2a02:26f0:9100:196::1d68
    Connexion à repo.mysql.com (repo.mysql.com)|104.85.20.87|:443… connecté.
    requête HTTP transmise, en attente de la réponse… 200 OK
    Taille : 13319 (13K) [application/x-redhat-package-manager]
    Sauvegarde en : « mysql80-community-release-el9-5.noarch.rpm »
    
    mysql80-community- 100%[================>]  13,01K  --.-KB/s    ds 0s
    
    2025-09-16 22:05:51 (85,9 MB/s) — « mysql80-community-release-el9-5.noarch.rpm » sauvegardé [13319/13319]

-----------------------------------------------------------------------------------------------------------------------------------    
    
    [root@kvm1 ~]# sudo rpm -ivh mysql80-community-release-el9-5.noarch.rpm
    
    attention : mysql80-community-release-el9-5.noarch.rpm: Header V4 RSA/SHA256 Signature, clé ID 3a79bd29: NOKEY
    Vérification...                                                        (100%################################# [100%]
    Préparation...                                                         (100%################################# [100%]
    Mise à jour / installation...
       1:mysql80-community-release-el9-5                                    ( 25################################# [100%]

le RPM de la partie précédente (comme sur le frontend)
ajoutez aussi les dépôts EPEL en exécutant :

    [root@kvm1 ~]# sudo dnf install -y epel-release 
    Dernière vérification de l’expiration des métadonnées effectuée il y a 0:01:41 le mar. 16 sept. 2025 22:06:14.
    Dépendances résolues.
    ============================================================================
     Paquet              Architecture  Version              Dépôt         Taille
    ============================================================================
    Installation:
     epel-release        noarch        10-6.el10_0          extras         18 k
    
    Résumé de la transaction
    ============================================================================
    Installer  1 Paquet
    
    Taille totale des téléchargements : 18 k
    Taille des paquets installés : 25 k
    Téléchargement des paquets :
    epel-release-10-6.el10_0.noarch.rpm         136 kB/s |  18 kB     00:00
    ----------------------------------------------------------------------------
    Total                                        49 kB/s |  18 kB     00:00
    Test de la transaction
    La vérification de la transaction a réussi.
    Lancement de la transaction de test
    Transaction de test réussie.
    Exécution de la transaction
      Préparation           :                                               1/1
      Installation          : epel-release-10-6.el10_0.noarch               1/1
      Exécution du scriptlet: epel-release-10-6.el10_0.noarch               1/1
    Many EPEL packages require the CodeReady Builder (CRB) repository.
    It is recommended that you run /usr/bin/crb enable to enable the CRB repository.
    
    
    Installé:
      epel-release-10-6.el10_0.noarch
    
    Terminé !


#### 🌞 Installer les libs MySQL

    [root@kvm1 ~]# sudo dnf install -y mysql-community-server
    
    Dernière vérification de l’expiration des métadonnées effectuée il y a 0:00:22 le mar. 16 sept. 2025 22:08:14.
    Dépendances résolues.
    ============================================================================
     Paquet                 Architecture
                                   Version              Dépôt             Taille
    ============================================================================
    Installation:
     mysql-community-server x86_64 8.0.43-1.el9         mysql80-community  50 M
    Installation des dépendances:
     libtirpc               x86_64 1.3.5-1.el10         baseos             94 k
     mysql-community-client x86_64 8.0.43-1.el9         mysql80-community 3.3 M
     mysql-community-client-plugins
                            x86_64 8.0.43-1.el9         mysql80-community 1.4 M
     mysql-community-common x86_64 8.0.43-1.el9         mysql80-community 556 k
     mysql-community-icu-data-files
                            x86_64 8.0.43-1.el9         mysql80-community 2.3 M
     mysql-community-libs   x86_64 8.0.43-1.el9         mysql80-community 1.5 M
     net-tools              x86_64 2.0-0.73.20160912git.el10
                                                        baseos            304 k
     perl-AutoLoader        noarch 5.74-512.2.el10_0    appstream          21 k
     perl-B                 x86_64 1.89-512.2.el10_0    appstream         180 k
     perl-Carp              noarch 1.54-511.el10        appstream          29 k
     perl-Class-Struct      noarch 0.68-512.2.el10_0    appstream          22 k
     perl-Data-Dumper       x86_64 2.189-512.el10       appstream          56 k
     perl-Digest            noarch 1.20-511.el10        appstream          25 k
     perl-Digest-MD5        x86_64 2.59-6.el10          appstream          36 k
     perl-DynaLoader        x86_64 1.56-512.2.el10_0    appstream          26 k
     perl-Encode            x86_64 4:3.21-511.el10      appstream         1.1 M
     perl-Errno             x86_64 1.38-512.2.el10_0    appstream          15 k
     perl-Exporter          noarch 5.78-511.el10        appstream          31 k
     perl-Fcntl             x86_64 1.18-512.2.el10_0    appstream          30 k
     perl-File-Basename     noarch 2.86-512.2.el10_0    appstream          17 k
     perl-File-Path         noarch 2.18-511.el10        appstream          35 k
     perl-File-Temp         noarch 1:0.231.100-512.el10 appstream          59 k
     perl-File-stat         noarch 1.14-512.2.el10_0    appstream          17 k
     perl-FileHandle        noarch 2.05-512.2.el10_0    appstream          15 k
     perl-Getopt-Long       noarch 1:2.58-3.el10        appstream          64 k
     perl-Getopt-Std        noarch 1.14-512.2.el10_0    appstream          15 k
     perl-HTTP-Tiny         noarch 0.088-512.el10       appstream          56 k
     perl-IO                x86_64 1.55-512.2.el10_0    appstream          83 k
     perl-IO-Socket-IP      noarch 0.42-512.el10        appstream          42 k
     perl-IO-Socket-SSL     noarch 2.085-3.el10         appstream         229 k
     perl-IPC-Open3         noarch 1.22-512.2.el10_0    appstream          22 k
     perl-MIME-Base64       x86_64 3.16-511.el10        appstream          30 k
     perl-Mozilla-CA        noarch 20231213-5.el10      appstream          14 k
     perl-Net-SSLeay        x86_64 1.94-7.el10          appstream         382 k
     perl-POSIX             x86_64 2.20-512.2.el10_0    appstream          96 k
     perl-PathTools         x86_64 3.91-512.el10        appstream          88 k
     perl-Pod-Escapes       noarch 1:1.07-511.el10      appstream          20 k
     perl-Pod-Perldoc       noarch 3.28.01-512.el10     appstream          87 k
     perl-Pod-Simple        noarch 1:3.45-511.el10      appstream         221 k
     perl-Pod-Usage         noarch 4:2.03-511.el10      appstream          40 k
     perl-Scalar-List-Utils x86_64 5:1.63-511.el10      appstream          73 k
     perl-SelectSaver       noarch 1.02-512.2.el10_0    appstream          11 k
     perl-Socket            x86_64 4:2.038-511.el10     appstream          55 k
     perl-Storable          x86_64 1:3.32-511.el10      appstream          98 k
     perl-Symbol            noarch 1.09-512.2.el10_0    appstream          14 k
     perl-Term-ANSIColor    noarch 5.01-512.el10        appstream          48 k
     perl-Term-Cap          noarch 1.18-511.el10        appstream          22 k
     perl-Text-ParseWords   noarch 3.31-511.el10        appstream          16 k
     perl-Text-Tabs+Wrap    noarch 2024.001-511.el10    appstream          22 k
     perl-Time-Local        noarch 2:1.350-511.el10     appstream          34 k
     perl-URI               noarch 5.27-3.el10          appstream         136 k
     perl-base              noarch 2.27-512.2.el10_0    appstream          16 k
     perl-constant          noarch 1.33-512.el10        appstream          23 k
     perl-if                noarch 0.61.000-512.2.el10_0
                                                        appstream          14 k
     perl-interpreter       x86_64 4:5.40.2-512.2.el10_0
                                                        appstream          72 k
     perl-libnet            noarch 3.15-512.el10        appstream         130 k
     perl-libs              x86_64 4:5.40.2-512.2.el10_0
                                                        appstream         2.4 M
     perl-locale            noarch 1.12-512.2.el10_0    appstream          13 k
     perl-mro               x86_64 1.29-512.2.el10_0    appstream          30 k
     perl-overload          noarch 1.37-512.2.el10_0    appstream          45 k
     perl-overloading       noarch 0.02-512.2.el10_0    appstream          13 k
     perl-parent            noarch 1:0.241-512.el10     appstream          15 k
     perl-podlators         noarch 1:5.01-511.el10      appstream         126 k
     perl-vars              noarch 1.05-512.2.el10_0    appstream          13 k
    Installation des dépendances faibles:
     perl-NDBM_File         x86_64 1.17-512.2.el10_0    appstream          22 k
    
    Résumé de la transaction
    ============================================================================
    Installer  66 Paquets
    
    Taille totale des téléchargements : 66 M
    Taille des paquets installés : 360 M
    Téléchargement des paquets :
    (1/66): mysql-community-client-plugins-8.0. 3.1 MB/s | 1.4 MB     00:00
    (2/66): mysql-community-common-8.0.43-1.el9 1.2 MB/s | 556 kB     00:00
    (3/66): mysql-community-libs-8.0.43-1.el9.x 5.3 MB/s | 1.5 MB     00:00
    (4/66): mysql-community-icu-data-files-8.0. 4.3 MB/s | 2.3 MB     00:00
    (5/66): libtirpc-1.3.5-1.el10.x86_64.rpm    254 kB/s |  94 kB     00:00
    (6/66): net-tools-2.0-0.73.20160912git.el10 1.3 MB/s | 304 kB     00:00
    (7/66): perl-AutoLoader-5.74-512.2.el10_0.n  84 kB/s |  21 kB     00:00
    (8/66): mysql-community-client-8.0.43-1.el9 1.6 MB/s | 3.3 MB     00:02
    (9/66): perl-B-1.89-512.2.el10_0.x86_64.rpm 500 kB/s | 180 kB     00:00
    (10/66): perl-Carp-1.54-511.el10.noarch.rpm 137 kB/s |  29 kB     00:00
    (11/66): perl-Class-Struct-0.68-512.2.el10_ 197 kB/s |  22 kB     00:00
    (12/66): perl-Digest-1.20-511.el10.noarch.r 146 kB/s |  25 kB     00:00
    (13/66): perl-Data-Dumper-2.189-512.el10.x8 208 kB/s |  56 kB     00:00
    (14/66): perl-Digest-MD5-2.59-6.el10.x86_64 311 kB/s |  36 kB     00:00
    (15/66): perl-DynaLoader-1.56-512.2.el10_0. 237 kB/s |  26 kB     00:00
    (16/66): perl-Errno-1.38-512.2.el10_0.x86_6  91 kB/s |  15 kB     00:00
    (17/66): perl-Exporter-5.78-511.el10.noarch 211 kB/s |  31 kB     00:00
    (18/66): perl-Fcntl-1.18-512.2.el10_0.x86_6 281 kB/s |  30 kB     00:00
    (19/66): perl-File-Basename-2.86-512.2.el10 171 kB/s |  17 kB     00:00
    (20/66): perl-Encode-3.21-511.el10.x86_64.r 1.7 MB/s | 1.1 MB     00:00
    (21/66): perl-File-Temp-0.231.100-512.el10. 464 kB/s |  59 kB     00:00
    (22/66): perl-File-Path-2.18-511.el10.noarc 229 kB/s |  35 kB     00:00
    (23/66): perl-FileHandle-2.05-512.2.el10_0. 192 kB/s |  15 kB     00:00
    (24/66): perl-File-stat-1.14-512.2.el10_0.n 150 kB/s |  17 kB     00:00
    (25/66): perl-Getopt-Std-1.14-512.2.el10_0. 125 kB/s |  15 kB     00:00
    (26/66): perl-Getopt-Long-2.58-3.el10.noarc 314 kB/s |  64 kB     00:00
    (27/66): perl-HTTP-Tiny-0.088-512.el10.noar 422 kB/s |  56 kB     00:00
    (28/66): perl-IO-Socket-IP-0.42-512.el10.no 264 kB/s |  42 kB     00:00
    (29/66): perl-IO-1.55-512.2.el10_0.x86_64.r 253 kB/s |  83 kB     00:00
    (30/66): perl-IPC-Open3-1.22-512.2.el10_0.n 205 kB/s |  22 kB     00:00
    (31/66): perl-IO-Socket-SSL-2.085-3.el10.no 1.0 MB/s | 229 kB     00:00
    (32/66): mysql-community-server-8.0.43-1.el  13 MB/s |  50 MB     00:03
    (33/66): perl-MIME-Base64-3.16-511.el10.x86  89 kB/s |  30 kB     00:00
    (34/66): perl-Mozilla-CA-20231213-5.el10.no  45 kB/s |  14 kB     00:00
    (35/66): perl-NDBM_File-1.17-512.2.el10_0.x 255 kB/s |  22 kB     00:00
    (36/66): perl-POSIX-2.20-512.2.el10_0.x86_6 426 kB/s |  96 kB     00:00
    (37/66): perl-PathTools-3.91-512.el10.x86_6 389 kB/s |  88 kB     00:00
    (38/66): perl-Pod-Escapes-1.07-511.el10.noa 198 kB/s |  20 kB     00:00
    (39/66): perl-Net-SSLeay-1.94-7.el10.x86_64 789 kB/s | 382 kB     00:00
    (40/66): perl-Pod-Perldoc-3.28.01-512.el10. 321 kB/s |  87 kB     00:00
    (41/66): perl-Pod-Usage-2.03-511.el10.noarc 344 kB/s |  40 kB     00:00
    (42/66): perl-SelectSaver-1.02-512.2.el10_0 135 kB/s |  11 kB     00:00
    (43/66): perl-Socket-2.038-511.el10.x86_64. 525 kB/s |  55 kB     00:00
    (44/66): perl-Scalar-List-Utils-1.63-511.el 283 kB/s |  73 kB     00:00
    (45/66): perl-Symbol-1.09-512.2.el10_0.noar 192 kB/s |  14 kB     00:00
    (46/66): perl-Storable-3.32-511.el10.x86_64 712 kB/s |  98 kB     00:00
    (47/66): perl-Term-ANSIColor-5.01-512.el10. 397 kB/s |  48 kB     00:00
    (48/66): perl-Term-Cap-1.18-511.el10.noarch 154 kB/s |  22 kB     00:00
    (49/66): perl-Text-ParseWords-3.31-511.el10 170 kB/s |  16 kB     00:00
    (50/66): perl-Pod-Simple-3.45-511.el10.noar 272 kB/s | 221 kB     00:00
    (51/66): perl-Text-Tabs+Wrap-2024.001-511.e 171 kB/s |  22 kB     00:00
    (52/66): perl-Time-Local-1.350-511.el10.noa 355 kB/s |  34 kB     00:00
    (53/66): perl-base-2.27-512.2.el10_0.noarch 196 kB/s |  16 kB     00:00
    (54/66): perl-constant-1.33-512.el10.noarch 192 kB/s |  23 kB     00:00
    (55/66): perl-if-0.61.000-512.2.el10_0.noar 155 kB/s |  14 kB     00:00
    (56/66): perl-interpreter-5.40.2-512.2.el10 697 kB/s |  72 kB     00:00
    (57/66): perl-URI-5.27-3.el10.noarch.rpm    297 kB/s | 136 kB     00:00
    (58/66): perl-libnet-3.15-512.el10.noarch.r 509 kB/s | 130 kB     00:00
    (59/66): perl-locale-1.12-512.2.el10_0.noar 160 kB/s |  13 kB     00:00
    (60/66): perl-mro-1.29-512.2.el10_0.x86_64. 280 kB/s |  30 kB     00:00
    (61/66): perl-overload-1.37-512.2.el10_0.no 331 kB/s |  45 kB     00:00
    (62/66): perl-overloading-0.02-512.2.el10_0 124 kB/s |  13 kB     00:00
    (63/66): perl-parent-0.241-512.el10.noarch. 130 kB/s |  15 kB     00:00
    (64/66): perl-vars-1.05-512.2.el10_0.noarch  76 kB/s |  13 kB     00:00
    (65/66): perl-podlators-5.01-511.el10.noarc 416 kB/s | 126 kB     00:00
    (66/66): perl-libs-5.40.2-512.2.el10_0.x86_ 613 kB/s | 2.4 MB     00:03
    ----------------------------------------------------------------------------
    Total                                       6.3 MB/s |  66 MB     00:10
    MySQL 8.0 Community Server                  3.0 MB/s | 3.1 kB     00:00
    Import de la clef GPG 0xA8D3785C :
    Utilisateur : « MySQL Release Engineering <mysql-build@oss.oracle.com> »
    Empreinte : BCA4 3417 C3B4 85DD 128E C6D4 B7B3 B788 A8D3 785C
    Provenance : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2023
    La clé a bien été importée
    MySQL 8.0 Community Server                  3.0 MB/s | 3.1 kB     00:00
    Import de la clef GPG 0x3A79BD29 :
    Utilisateur : « MySQL Release Engineering <mysql-build@oss.oracle.com> »
    Empreinte : 859B E8D7 C586 F538 430B 19C2 467B 942D 3A79 BD29
    Provenance : /etc/pki/rpm-gpg/RPM-GPG-KEY-mysql-2022
    attention : Certificate 467B942D3A79BD29:
      The certificate is expired: The primary key is not live
      Subkey 467B942D3A79BD29 is expired: The primary key is not live
      Certificate does not have any usable signing keys
    La clé a bien été importée
    Test de la transaction
    La vérification de la transaction a réussi.
    Lancement de la transaction de test
    Transaction de test réussie.
    Exécution de la transaction
      Préparation           :                                               1/1
      Installation          : mysql-community-common-8.0.43-1.el9.x86_6    1/66
      Installation          : mysql-community-client-plugins-8.0.43-1.e    2/66
      Installation          : mysql-community-libs-8.0.43-1.el9.x86_64     3/66
      Exécution du scriptlet: mysql-community-libs-8.0.43-1.el9.x86_64     3/66
      Installation          : mysql-community-client-8.0.43-1.el9.x86_6    4/66
      Installation          : perl-Digest-1.20-511.el10.noarch             5/66
      Installation          : perl-Digest-MD5-2.59-6.el10.x86_64           6/66
      Installation          : perl-B-1.89-512.2.el10_0.x86_64              7/66
      Installation          : perl-FileHandle-2.05-512.2.el10_0.noarch     8/66
      Installation          : perl-Data-Dumper-2.189-512.el10.x86_64       9/66
      Installation          : perl-libnet-3.15-512.el10.noarch            10/66
      Installation          : perl-URI-5.27-3.el10.noarch                 11/66
      Installation          : perl-AutoLoader-5.74-512.2.el10_0.noarch    12/66
      Installation          : perl-Text-Tabs+Wrap-2024.001-511.el10.noa   13/66
      Installation          : perl-Mozilla-CA-20231213-5.el10.noarch      14/66
      Installation          : perl-if-0.61.000-512.2.el10_0.noarch        15/66
      Installation          : perl-locale-1.12-512.2.el10_0.noarch        16/66
      Installation          : perl-IO-Socket-IP-0.42-512.el10.noarch      17/66
      Installation          : perl-Time-Local-2:1.350-511.el10.noarch     18/66
      Installation          : perl-File-Path-2.18-511.el10.noarch         19/66
      Installation          : perl-Pod-Escapes-1:1.07-511.el10.noarch     20/66
      Installation          : perl-IO-Socket-SSL-2.085-3.el10.noarch      21/66
      Installation          : perl-Net-SSLeay-1.94-7.el10.x86_64          22/66
      Installation          : perl-Class-Struct-0.68-512.2.el10_0.noarc   23/66
      Installation          : perl-Term-ANSIColor-5.01-512.el10.noarch    24/66
      Installation          : perl-POSIX-2.20-512.2.el10_0.x86_64         25/66
      Installation          : perl-IPC-Open3-1.22-512.2.el10_0.noarch     26/66
      Installation          : perl-File-Temp-1:0.231.100-512.el10.noarc   27/66
      Installation          : perl-Term-Cap-1.18-511.el10.noarch          28/66
      Installation          : perl-Pod-Simple-1:3.45-511.el10.noarch      29/66
      Installation          : perl-HTTP-Tiny-0.088-512.el10.noarch        30/66
      Installation          : perl-Socket-4:2.038-511.el10.x86_64         31/66
      Installation          : perl-SelectSaver-1.02-512.2.el10_0.noarch   32/66
      Installation          : perl-Symbol-1.09-512.2.el10_0.noarch        33/66
      Installation          : perl-File-stat-1.14-512.2.el10_0.noarch     34/66
      Installation          : perl-podlators-1:5.01-511.el10.noarch       35/66
      Installation          : perl-Pod-Perldoc-3.28.01-512.el10.noarch    36/66
      Installation          : perl-Fcntl-1.18-512.2.el10_0.x86_64         37/66
      Installation          : perl-Text-ParseWords-3.31-511.el10.noarch   38/66
      Installation          : perl-base-2.27-512.2.el10_0.noarch          39/66
      Installation          : perl-mro-1.29-512.2.el10_0.x86_64           40/66
      Installation          : perl-IO-1.55-512.2.el10_0.x86_64            41/66
      Installation          : perl-overloading-0.02-512.2.el10_0.noarch   42/66
      Installation          : perl-Pod-Usage-4:2.03-511.el10.noarch       43/66
      Installation          : perl-Errno-1.38-512.2.el10_0.x86_64         44/66
      Installation          : perl-File-Basename-2.86-512.2.el10_0.noar   45/66
      Installation          : perl-Getopt-Std-1.14-512.2.el10_0.noarch    46/66
      Installation          : perl-MIME-Base64-3.16-511.el10.x86_64       47/66
      Installation          : perl-Scalar-List-Utils-5:1.63-511.el10.x8   48/66
      Installation          : perl-constant-1.33-512.el10.noarch          49/66
      Installation          : perl-Storable-1:3.32-511.el10.x86_64        50/66
      Installation          : perl-overload-1.37-512.2.el10_0.noarch      51/66
      Installation          : perl-parent-1:0.241-512.el10.noarch         52/66
      Installation          : perl-vars-1.05-512.2.el10_0.noarch          53/66
      Installation          : perl-Getopt-Long-1:2.58-3.el10.noarch       54/66
      Installation          : perl-Carp-1.54-511.el10.noarch              55/66
      Installation          : perl-Exporter-5.78-511.el10.noarch          56/66
      Installation          : perl-NDBM_File-1.17-512.2.el10_0.x86_64     57/66
      Installation          : perl-PathTools-3.91-512.el10.x86_64         58/66
      Installation          : perl-DynaLoader-1.56-512.2.el10_0.x86_64    59/66
      Installation          : perl-Encode-4:3.21-511.el10.x86_64          60/66
      Installation          : perl-libs-4:5.40.2-512.2.el10_0.x86_64      61/66
      Installation          : perl-interpreter-4:5.40.2-512.2.el10_0.x8   62/66
      Installation          : net-tools-2.0-0.73.20160912git.el10.x86_6   63/66
      Exécution du scriptlet: net-tools-2.0-0.73.20160912git.el10.x86_6   63/66
      Installation          : libtirpc-1.3.5-1.el10.x86_64                64/66
      Installation          : mysql-community-icu-data-files-8.0.43-1.e   65/66
      Exécution du scriptlet: mysql-community-server-8.0.43-1.el9.x86_6   66/66
      Installation          : mysql-community-server-8.0.43-1.el9.x86_6   66/66
      Exécution du scriptlet: mysql-community-server-8.0.43-1.el9.x86_6   66/66
    
    Installé:
      libtirpc-1.3.5-1.el10.x86_64
      mysql-community-client-8.0.43-1.el9.x86_64
      mysql-community-client-plugins-8.0.43-1.el9.x86_64
      mysql-community-common-8.0.43-1.el9.x86_64
      mysql-community-icu-data-files-8.0.43-1.el9.x86_64
      mysql-community-libs-8.0.43-1.el9.x86_64
      mysql-community-server-8.0.43-1.el9.x86_64
      net-tools-2.0-0.73.20160912git.el10.x86_64
      perl-AutoLoader-5.74-512.2.el10_0.noarch
      perl-B-1.89-512.2.el10_0.x86_64
      perl-Carp-1.54-511.el10.noarch
      perl-Class-Struct-0.68-512.2.el10_0.noarch
      perl-Data-Dumper-2.189-512.el10.x86_64
      perl-Digest-1.20-511.el10.noarch
      perl-Digest-MD5-2.59-6.el10.x86_64
      perl-DynaLoader-1.56-512.2.el10_0.x86_64
      perl-Encode-4:3.21-511.el10.x86_64
      perl-Errno-1.38-512.2.el10_0.x86_64
      perl-Exporter-5.78-511.el10.noarch
      perl-Fcntl-1.18-512.2.el10_0.x86_64
      perl-File-Basename-2.86-512.2.el10_0.noarch
      perl-File-Path-2.18-511.el10.noarch
      perl-File-Temp-1:0.231.100-512.el10.noarch
      perl-File-stat-1.14-512.2.el10_0.noarch
      perl-FileHandle-2.05-512.2.el10_0.noarch
      perl-Getopt-Long-1:2.58-3.el10.noarch
      perl-Getopt-Std-1.14-512.2.el10_0.noarch
      perl-HTTP-Tiny-0.088-512.el10.noarch
      perl-IO-1.55-512.2.el10_0.x86_64
      perl-IO-Socket-IP-0.42-512.el10.noarch
      perl-IO-Socket-SSL-2.085-3.el10.noarch
      perl-IPC-Open3-1.22-512.2.el10_0.noarch
      perl-MIME-Base64-3.16-511.el10.x86_64
      perl-Mozilla-CA-20231213-5.el10.noarch
      perl-NDBM_File-1.17-512.2.el10_0.x86_64
      perl-Net-SSLeay-1.94-7.el10.x86_64
      perl-POSIX-2.20-512.2.el10_0.x86_64
      perl-PathTools-3.91-512.el10.x86_64
      perl-Pod-Escapes-1:1.07-511.el10.noarch
      perl-Pod-Perldoc-3.28.01-512.el10.noarch
      perl-Pod-Simple-1:3.45-511.el10.noarch
      perl-Pod-Usage-4:2.03-511.el10.noarch
      perl-Scalar-List-Utils-5:1.63-511.el10.x86_64
      perl-SelectSaver-1.02-512.2.el10_0.noarch
      perl-Socket-4:2.038-511.el10.x86_64
      perl-Storable-1:3.32-511.el10.x86_64
      perl-Symbol-1.09-512.2.el10_0.noarch
      perl-Term-ANSIColor-5.01-512.el10.noarch
      perl-Term-Cap-1.18-511.el10.noarch
      perl-Text-ParseWords-3.31-511.el10.noarch
      perl-Text-Tabs+Wrap-2024.001-511.el10.noarch
      perl-Time-Local-2:1.350-511.el10.noarch
      perl-URI-5.27-3.el10.noarch
      perl-base-2.27-512.2.el10_0.noarch
      perl-constant-1.33-512.el10.noarch
      perl-if-0.61.000-512.2.el10_0.noarch
      perl-interpreter-4:5.40.2-512.2.el10_0.x86_64
      perl-libnet-3.15-512.el10.noarch
      perl-libs-4:5.40.2-512.2.el10_0.x86_64
      perl-locale-1.12-512.2.el10_0.noarch
      perl-mro-1.29-512.2.el10_0.x86_64
      perl-overload-1.37-512.2.el10_0.noarch
      perl-overloading-0.02-512.2.el10_0.noarch
      perl-parent-1:0.241-512.el10.noarch
      perl-podlators-1:5.01-511.el10.noarch
      perl-vars-1.05-512.2.el10_0.noarch
    
    Terminé !
    
#### 🌞 Installer KVM

un paquet spécifique qui vient des dépôts OpenNebula : opennebula-node-kvm

         [root@kvm1 ~]# dnf install opennebula-node-kvm
        Last metadata expiration check: 3:08:00 ago on Wed Sep 17 11:51:56 2025.
        Dependencies resolved.
        ============================================================================
         Package                        Arch   Version             Repository  Size
        ============================================================================
        Installing:
         opennebula-node-kvm            noarch 6.10.0.1-1.el9      opennebula  13 k
        Installing dependencies:
         augeas                         x86_64 1.14.1-2.el9        appstream   63 k
         augeas-libs                    x86_64 1.14.1-2.el9        appstream  373 k
         boost-iostreams                x86_64 1.75.0-10.el9       appstream   36 k
         capstone                       x86_64 4.0.2-10.el9        appstream  766 k
         cyrus-sasl-gssapi              x86_64 2.1.27-21.el9       baseos      26 k
         daxctl-libs                    x86_64 78-2.el9            baseos      41 k
         device-mapper-multipath-libs   x86_64 0.8.7-35.el9_6.1    baseos     267 k
         dmidecode                      x86_64 1:3.6-1.el9         baseos     100 k
         dnsmasq                        x86_64 2.85-16.el9_4       appstream  326 k
         edk2-ovmf                      noarch 20241117-2.el9      appstream  6.1 M
         gnutls-dane                    x86_64 3.8.3-6.el9         appstream   18 k
         gnutls-utils                   x86_64 3.8.3-6.el9         appstream  283 k
         gssproxy                       x86_64 0.8.4-7.el9         baseos     108 k
         ipxe-roms-qemu                 noarch 20200823-9.git4bd064de.el9
                                                                   appstream  673 k
         iscsi-initiator-utils          x86_64 6.2.1.9-1.gita65a472.el9
                                                                   baseos     383 k
         iscsi-initiator-utils-iscsiuio x86_64 6.2.1.9-1.gita65a472.el9
                                                                   baseos      80 k
         isns-utils-libs                x86_64 0.101-4.el9         baseos     100 k
         libblkio                       x86_64 1.5.0-1.el9_4       appstream  1.0 M
         libbsd                         x86_64 0.12.2-1.el9        epel       120 k
         libev                          x86_64 4.33-6.el9          baseos      51 k
         libfdt                         x86_64 1.6.0-7.el9         appstream   33 k
         libibverbs                     x86_64 54.0-1.el9          baseos     434 k
         libmd                          x86_64 1.1.0-1.el9         epel        46 k
         libnbd                         x86_64 1.20.3-1.el9        appstream  168 k
         libnfsidmap                    x86_64 1:2.5.4-34.el9      baseos      60 k
         libpcap                        x86_64 14:1.10.0-4.el9     baseos     172 k
         libpmem                        x86_64 1.12.1-1.el9        appstream  111 k
         librados2                      x86_64 2:16.2.4-5.el9      appstream  3.4 M
         librbd1                        x86_64 2:16.2.4-5.el9      appstream  3.0 M
         librdmacm                      x86_64 54.0-1.el9          baseos      70 k
         libretls                       x86_64 3.8.1-1.el9         epel        41 k
         libslirp                       x86_64 4.4.0-8.el9         appstream   67 k
         libtpms                        x86_64 0.9.1-5.20211126git1ff6fe1f43.el9_6
                                                                   appstream  182 k
         liburing                       x86_64 2.5-1.el9           appstream   38 k
         libverto-libev                 x86_64 0.3.2-3.el9         baseos      13 k
         libvirt                        x86_64 10.10.0-7.6.el9_6   appstream   29 k
         libvirt-client                 x86_64 10.10.0-7.6.el9_6   appstream  449 k
         libvirt-client-qemu            x86_64 10.10.0-7.6.el9_6   appstream   49 k
         libvirt-daemon                 x86_64 10.10.0-7.6.el9_6   appstream  215 k
         libvirt-daemon-common          x86_64 10.10.0-7.6.el9_6   appstream  137 k
         libvirt-daemon-config-network  x86_64 10.10.0-7.6.el9_6   appstream   31 k
         libvirt-daemon-config-nwfilter x86_64 10.10.0-7.6.el9_6   appstream   37 k
         libvirt-daemon-driver-interface
                                        x86_64 10.10.0-7.6.el9_6   appstream  221 k
         libvirt-daemon-driver-network  x86_64 10.10.0-7.6.el9_6   appstream  270 k
         libvirt-daemon-driver-nodedev  x86_64 10.10.0-7.6.el9_6   appstream  245 k
         libvirt-daemon-driver-nwfilter x86_64 10.10.0-7.6.el9_6   appstream  257 k
         libvirt-daemon-driver-qemu     x86_64 10.10.0-7.6.el9_6   appstream  991 k
         libvirt-daemon-driver-secret   x86_64 10.10.0-7.6.el9_6   appstream  218 k
         libvirt-daemon-driver-storage  x86_64 10.10.0-7.6.el9_6   appstream   28 k
         libvirt-daemon-driver-storage-core
                                        x86_64 10.10.0-7.6.el9_6   appstream  273 k
         libvirt-daemon-driver-storage-disk
                                        x86_64 10.10.0-7.6.el9_6   appstream   39 k
         libvirt-daemon-driver-storage-iscsi
                                        x86_64 10.10.0-7.6.el9_6   appstream   37 k
         libvirt-daemon-driver-storage-logical
                                        x86_64 10.10.0-7.6.el9_6   appstream   41 k
         libvirt-daemon-driver-storage-mpath
                                        x86_64 10.10.0-7.6.el9_6   appstream   34 k
         libvirt-daemon-driver-storage-rbd
                                        x86_64 10.10.0-7.6.el9_6   appstream   45 k
         libvirt-daemon-driver-storage-scsi
                                        x86_64 10.10.0-7.6.el9_6   appstream   36 k
         libvirt-daemon-lock            x86_64 10.10.0-7.6.el9_6   appstream   66 k
         libvirt-daemon-log             x86_64 10.10.0-7.6.el9_6   appstream   70 k
         libvirt-daemon-plugin-lockd    x86_64 10.10.0-7.6.el9_6   appstream   40 k
         libvirt-daemon-proxy           x86_64 10.10.0-7.6.el9_6   appstream  214 k
         libvirt-libs                   x86_64 10.10.0-7.6.el9_6   appstream  5.0 M
         lzop                           x86_64 1.04-8.el9          baseos      55 k
         mdevctl                        x86_64 1.1.0-4.el9         appstream  758 k
         nbdkit-basic-filters           x86_64 1.38.5-5.el9_6      appstream  308 k
         nbdkit-basic-plugins           x86_64 1.38.5-5.el9_6      appstream  207 k
         nbdkit-selinux                 noarch 1.38.5-5.el9_6      appstream   23 k
         nbdkit-server                  x86_64 1.38.5-5.el9_6      appstream  128 k
         ndctl-libs                     x86_64 78-2.el9            baseos      89 k
         nfs-utils                      x86_64 1:2.5.4-34.el9      baseos     430 k
         numad                          x86_64 0.5-37.20150602git.el9
                                                                   baseos      36 k
         opennebula-common              noarch 6.10.0.1-1.el9      opennebula  23 k
         opennebula-common-onecfg       noarch 6.10.0.1-1.el9      opennebula 9.1 k
         opennebula-rubygems            x86_64 6.10.0.1-1.el9      opennebula  16 M
         passt-selinux                  noarch 0^20250217.ga1e48a0-10.el9_6
                                                                   appstream   27 k
         pciutils                       x86_64 3.7.0-7.el9         baseos      92 k
         protobuf-c                     x86_64 1.3.3-13.el9        baseos      34 k
         python3-cffi                   x86_64 1.14.5-5.el9        baseos     241 k
         python3-cryptography           x86_64 36.0.1-4.el9        baseos     1.2 M
         python3-libvirt                x86_64 10.10.0-1.el9       appstream  333 k
         python3-lxml                   x86_64 4.6.5-3.el9         appstream  1.2 M
         python3-ply                    noarch 3.11-14.el9.0.1     baseos     103 k
         python3-pycparser              noarch 2.20-6.el9          baseos     124 k
         python3-pyyaml                 x86_64 5.4.1-6.el9         baseos     191 k
         qemu-img                       x86_64 17:9.1.0-15.el9_6.7 appstream  2.5 M
         qemu-kvm                       x86_64 17:9.1.0-15.el9_6.7 appstream   64 k
         qemu-kvm-audio-pa              x86_64 17:9.1.0-15.el9_6.7 appstream   73 k
         qemu-kvm-block-blkio           x86_64 17:9.1.0-15.el9_6.7 appstream   76 k
         qemu-kvm-block-rbd             x86_64 17:9.1.0-15.el9_6.7 appstream   78 k
         qemu-kvm-common                x86_64 17:9.1.0-15.el9_6.7 appstream  668 k
         qemu-kvm-core                  x86_64 17:9.1.0-15.el9_6.7 appstream  4.9 M
         qemu-kvm-device-display-virtio-gpu
                                        x86_64 17:9.1.0-15.el9_6.7 appstream   85 k
         qemu-kvm-device-display-virtio-gpu-pci
                                        x86_64 17:9.1.0-15.el9_6.7 appstream   68 k
         qemu-kvm-device-display-virtio-vga
                                        x86_64 17:9.1.0-15.el9_6.7 appstream   69 k
         qemu-kvm-device-usb-host       x86_64 17:9.1.0-15.el9_6.7 appstream   82 k
         qemu-kvm-device-usb-redirect   x86_64 17:9.1.0-15.el9_6.7 appstream   87 k
         qemu-kvm-docs                  x86_64 17:9.1.0-15.el9_6.7 appstream  1.2 M
         qemu-kvm-tools                 x86_64 17:9.1.0-15.el9_6.7 appstream  571 k
         qemu-kvm-ui-egl-headless       x86_64 17:9.1.0-15.el9_6.7 appstream   69 k
         qemu-kvm-ui-opengl             x86_64 17:9.1.0-15.el9_6.7 appstream   76 k
         qemu-pr-helper                 x86_64 17:9.1.0-15.el9_6.7 appstream  492 k
         quota                          x86_64 1:4.09-4.el9        baseos     188 k
         quota-nls                      noarch 1:4.09-4.el9        baseos      76 k
         rpcbind                        x86_64 1.2.6-7.el9         baseos      56 k
         rsync                          x86_64 3.2.5-3.el9         baseos     403 k
         rubygem-rexml                  noarch 3.2.5-165.el9_5     appstream   92 k
         rubygem-sqlite3                x86_64 1.4.2-8.el9         epel        44 k
         scrub                          x86_64 2.6.1-4.el9         appstream   44 k
         seabios-bin                    noarch 1.16.3-4.el9        appstream  100 k
         seavgabios-bin                 noarch 1.16.3-4.el9        appstream   34 k
         sssd-nfs-idmap                 x86_64 2.9.6-4.el9_6.2     baseos      39 k
         swtpm                          x86_64 0.8.0-2.el9_4       appstream   42 k
         swtpm-libs                     x86_64 0.8.0-2.el9_4       appstream   48 k
         swtpm-tools                    x86_64 0.8.0-2.el9_4       appstream  116 k
         systemd-container              x86_64 252-51.el9_6.1      baseos     577 k
         unbound-libs                   x86_64 1.16.2-19.el9_6.1   appstream  550 k
         usbredir                       x86_64 0.13.0-2.el9        appstream   50 k
         virtiofsd                      x86_64 1.13.2-1.el9_6      appstream  990 k
        Installing weak dependencies:
         nbdkit                         x86_64 1.38.5-5.el9_6      appstream  8.5 k
         nbdkit-curl-plugin             x86_64 1.38.5-5.el9_6      appstream   39 k
         nbdkit-ssh-plugin              x86_64 1.38.5-5.el9_6      appstream   28 k
         netcat                         x86_64 1.229-1.el9         epel        34 k
         passt                          x86_64 0^20250217.ga1e48a0-10.el9_6
                                                                   appstream  259 k
        
        Transaction Summary
        ============================================================================
        Install  123 Packages
        
        Total download size: 64 M
        Installed size: 415 M
        Is this ok [y/N]: y
        Downloading Packages:
        (1/123): libmd-1.1.0-1.el9.x86_64.rpm       219 kB/s |  46 kB     00:00
        (2/123): libretls-3.8.1-1.el9.x86_64.rpm    183 kB/s |  41 kB     00:00
        (3/123): libbsd-0.12.2-1.el9.x86_64.rpm     423 kB/s | 120 kB     00:00
        (4/123): opennebula-common-6.10.0.1-1.el9.n 115 kB/s |  23 kB     00:00
        (5/123): opennebula-common-onecfg-6.10.0.1- 290 kB/s | 9.1 kB     00:00
        (6/123): opennebula-node-kvm-6.10.0.1-1.el9 385 kB/s |  13 kB     00:00
        (7/123): netcat-1.229-1.el9.x86_64.rpm       82 kB/s |  34 kB     00:00
        (8/123): rubygem-sqlite3-1.4.2-8.el9.x86_64  59 kB/s |  44 kB     00:00
        (9/123): python3-pycparser-2.20-6.el9.noarc 310 kB/s | 124 kB     00:00
        (10/123): protobuf-c-1.3.3-13.el9.x86_64.rp 265 kB/s |  34 kB     00:00
        (11/123): isns-utils-libs-0.101-4.el9.x86_6 397 kB/s | 100 kB     00:00
        (12/123): sssd-nfs-idmap-2.9.6-4.el9_6.2.x8 218 kB/s |  39 kB     00:00
        (13/123): numad-0.5-37.20150602git.el9.x86_ 273 kB/s |  36 kB     00:00
        (14/123): opennebula-rubygems-6.10.0.1-1.el  15 MB/s |  16 MB     00:01
        (15/123): python3-pyyaml-5.4.1-6.el9.x86_64 506 kB/s | 191 kB     00:00
        (16/123): lzop-1.04-8.el9.x86_64.rpm        385 kB/s |  55 kB     00:00
        (17/123): librdmacm-54.0-1.el9.x86_64.rpm   511 kB/s |  70 kB     00:00
        (18/123): cyrus-sasl-gssapi-2.1.27-21.el9.x 266 kB/s |  26 kB     00:00
        (19/123): iscsi-initiator-utils-6.2.1.9-1.g 510 kB/s | 383 kB     00:00
        (20/123): device-mapper-multipath-libs-0.8. 711 kB/s | 267 kB     00:00
        (21/123): quota-4.09-4.el9.x86_64.rpm       504 kB/s | 188 kB     00:00
        (22/123): python3-ply-3.11-14.el9.0.1.noarc 547 kB/s | 103 kB     00:00
        (23/123): quota-nls-4.09-4.el9.noarch.rpm   576 kB/s |  76 kB     00:00
        (24/123): iscsi-initiator-utils-iscsiuio-6. 174 kB/s |  80 kB     00:00
        (25/123): gssproxy-0.8.4-7.el9.x86_64.rpm   458 kB/s | 108 kB     00:00
        (26/123): ndctl-libs-78-2.el9.x86_64.rpm    647 kB/s |  89 kB     00:00
        (27/123): dmidecode-3.6-1.el9.x86_64.rpm    104 kB/s | 100 kB     00:00
        (28/123): libibverbs-54.0-1.el9.x86_64.rpm  506 kB/s | 434 kB     00:00
        (29/123): libev-4.33-6.el9.x86_64.rpm       426 kB/s |  51 kB     00:00
        (30/123): libverto-libev-0.3.2-3.el9.x86_64 207 kB/s |  13 kB     00:00
        (31/123): libpcap-1.10.0-4.el9.x86_64.rpm   807 kB/s | 172 kB     00:00
        (32/123): python3-cffi-1.14.5-5.el9.x86_64. 589 kB/s | 241 kB     00:00
        (33/123): systemd-container-252-51.el9_6.1. 969 kB/s | 577 kB     00:00
        (34/123): nfs-utils-2.5.4-34.el9.x86_64.rpm 518 kB/s | 430 kB     00:00
        (35/123): rpcbind-1.2.6-7.el9.x86_64.rpm    494 kB/s |  56 kB     00:00
        (36/123): pciutils-3.7.0-7.el9.x86_64.rpm   686 kB/s |  92 kB     00:00
        (37/123): libnfsidmap-2.5.4-34.el9.x86_64.r 425 kB/s |  60 kB     00:00
        (38/123): daxctl-libs-78-2.el9.x86_64.rpm   473 kB/s |  41 kB     00:00
        (39/123): libslirp-4.4.0-8.el9.x86_64.rpm   278 kB/s |  67 kB     00:00
        (40/123): rsync-3.2.5-3.el9.x86_64.rpm      1.1 MB/s | 403 kB     00:00
        (41/123): libvirt-daemon-plugin-lockd-10.10 650 kB/s |  40 kB     00:00
        (42/123): dnsmasq-2.85-16.el9_4.x86_64.rpm  2.1 MB/s | 326 kB     00:00
        (43/123): libvirt-daemon-proxy-10.10.0-7.6. 1.3 MB/s | 214 kB     00:00
        (44/123): passt-selinux-0^20250217.ga1e48a0 507 kB/s |  27 kB     00:00
        (45/123): virtiofsd-1.13.2-1.el9_6.x86_64.r 6.2 MB/s | 990 kB     00:00
        (46/123): libvirt-daemon-10.10.0-7.6.el9_6. 1.1 MB/s | 215 kB     00:00
        (47/123): libvirt-daemon-lock-10.10.0-7.6.e 534 kB/s |  66 kB     00:00
        (48/123): libvirt-libs-10.10.0-7.6.el9_6.x8 8.7 MB/s | 5.0 MB     00:00
        (49/123): swtpm-0.8.0-2.el9_4.x86_64.rpm     81 kB/s |  42 kB     00:00
        (50/123): swtpm-tools-0.8.0-2.el9_4.x86_64. 1.6 MB/s | 116 kB     00:00
        (51/123): nbdkit-selinux-1.38.5-5.el9_6.noa 303 kB/s |  23 kB     00:00
        (52/123): libvirt-daemon-driver-nodedev-10. 2.5 MB/s | 245 kB     00:00
        (53/123): passt-0^20250217.ga1e48a0-10.el9_ 1.6 MB/s | 259 kB     00:00
        (54/123): qemu-kvm-block-rbd-9.1.0-15.el9_6 1.1 MB/s |  78 kB     00:00
        (55/123): libvirt-daemon-log-10.10.0-7.6.el 963 kB/s |  70 kB     00:00
        (56/123): python3-cryptography-36.0.1-4.el9 218 kB/s | 1.2 MB     00:05
        (57/123): augeas-libs-1.14.1-2.el9.x86_64.r 2.4 MB/s | 373 kB     00:00
        (58/123): libnbd-1.20.3-1.el9.x86_64.rpm    1.7 MB/s | 168 kB     00:00
        (59/123): libtpms-0.9.1-5.20211126git1ff6fe 1.9 MB/s | 182 kB     00:00
        (60/123): seavgabios-bin-1.16.3-4.el9.noarc 354 kB/s |  34 kB     00:00
        (61/123): liburing-2.5-1.el9.x86_64.rpm     272 kB/s |  38 kB     00:00
        (62/123): nbdkit-server-1.38.5-5.el9_6.x86_ 1.2 MB/s | 128 kB     00:00
        (63/123): libvirt-daemon-config-network-10. 348 kB/s |  31 kB     00:00
        (64/123): qemu-kvm-docs-9.1.0-15.el9_6.7.x8 5.7 MB/s | 1.2 MB     00:00
        (65/123): scrub-2.6.1-4.el9.x86_64.rpm      216 kB/s |  44 kB     00:00
        (66/123): qemu-kvm-device-display-virtio-gp 419 kB/s |  85 kB     00:00
        (67/123): libvirt-daemon-driver-storage-mpa 653 kB/s |  34 kB     00:00
        (68/123): libvirt-daemon-driver-storage-cor 3.0 MB/s | 273 kB     00:00
        (69/123): qemu-kvm-device-usb-redirect-9.1. 784 kB/s |  87 kB     00:00
        (70/123): libvirt-daemon-driver-storage-isc 403 kB/s |  37 kB     00:00
        (71/123): libvirt-client-10.10.0-7.6.el9_6. 2.6 MB/s | 449 kB     00:00
        (72/123): ipxe-roms-qemu-20200823-9.git4bd0 2.3 MB/s | 673 kB     00:00
        (73/123): libvirt-daemon-driver-nwfilter-10 821 kB/s | 257 kB     00:00
        (74/123): capstone-4.0.2-10.el9.x86_64.rpm  2.4 MB/s | 766 kB     00:00
        (75/123): libvirt-daemon-driver-storage-log 209 kB/s |  41 kB     00:00
        (76/123): nbdkit-curl-plugin-1.38.5-5.el9_6 241 kB/s |  39 kB     00:00
        (77/123): qemu-kvm-ui-egl-headless-9.1.0-15 659 kB/s |  69 kB     00:00
        (78/123): qemu-kvm-core-9.1.0-15.el9_6.7.x8 5.5 MB/s | 4.9 MB     00:00
        (79/123): qemu-kvm-9.1.0-15.el9_6.7.x86_64.  71 kB/s |  64 kB     00:00
        (80/123): qemu-pr-helper-9.1.0-15.el9_6.7.x 570 kB/s | 492 kB     00:00
        (81/123): libpmem-1.12.1-1.el9.x86_64.rpm   1.5 MB/s | 111 kB     00:00
        (82/123): gnutls-dane-3.8.3-6.el9.x86_64.rp 167 kB/s |  18 kB     00:00
        (83/123): augeas-1.14.1-2.el9.x86_64.rpm    496 kB/s |  63 kB     00:00
        (84/123): swtpm-libs-0.8.0-2.el9_4.x86_64.r 423 kB/s |  48 kB     00:00
        (85/123): libvirt-daemon-common-10.10.0-7.6 1.0 MB/s | 137 kB     00:00
        (86/123): libvirt-daemon-driver-storage-dis 344 kB/s |  39 kB     00:00
        (87/123): qemu-img-9.1.0-15.el9_6.7.x86_64. 6.0 MB/s | 2.5 MB     00:00
        (88/123): unbound-libs-1.16.2-19.el9_6.1.x8 1.4 MB/s | 550 kB     00:00
        (89/123): nbdkit-ssh-plugin-1.38.5-5.el9_6.  87 kB/s |  28 kB     00:00
        (90/123): qemu-kvm-device-display-virtio-vg 896 kB/s |  69 kB     00:00
        (91/123): boost-iostreams-1.75.0-10.el9.x86 691 kB/s |  36 kB     00:00
        (92/123): libvirt-daemon-driver-interface-1 1.9 MB/s | 221 kB     00:00
        (93/123): usbredir-0.13.0-2.el9.x86_64.rpm  628 kB/s |  50 kB     00:00
        (94/123): rubygem-rexml-3.2.5-165.el9_5.noa 1.2 MB/s |  92 kB     00:00
        (95/123): qemu-kvm-device-usb-host-9.1.0-15 1.1 MB/s |  82 kB     00:00
        (96/123): qemu-kvm-device-display-virtio-gp 607 kB/s |  68 kB     00:00
        (97/123): seabios-bin-1.16.3-4.el9.noarch.r 898 kB/s | 100 kB     00:00
        (98/123): nbdkit-basic-plugins-1.38.5-5.el9 1.6 MB/s | 207 kB     00:00
        (99/123): gnutls-utils-3.8.3-6.el9.x86_64.r 1.7 MB/s | 283 kB     00:00
        (100/123): libvirt-daemon-config-nwfilter-1 229 kB/s |  37 kB     00:00
        (101/123): qemu-kvm-block-blkio-9.1.0-15.el 665 kB/s |  76 kB     00:00
        (102/123): libvirt-daemon-driver-secret-10. 2.0 MB/s | 218 kB     00:00
        (103/123): libblkio-1.5.0-1.el9_4.x86_64.rp 3.7 MB/s | 1.0 MB     00:00
        (104/123): mdevctl-1.1.0-4.el9.x86_64.rpm   2.3 MB/s | 758 kB     00:00
        (105/123): python3-libvirt-10.10.0-1.el9.x8 1.1 MB/s | 333 kB     00:00
        (106/123): libvirt-daemon-driver-qemu-10.10 4.1 MB/s | 991 kB     00:00
        (107/123): libvirt-daemon-driver-storage-sc 263 kB/s |  36 kB     00:00
        (108/123): qemu-kvm-tools-9.1.0-15.el9_6.7. 3.7 MB/s | 571 kB     00:00
        (109/123): edk2-ovmf-20241117-2.el9.noarch. 6.9 MB/s | 6.1 MB     00:00
        (110/123): nbdkit-1.38.5-5.el9_6.x86_64.rpm 9.6 kB/s | 8.5 kB     00:00
        (111/123): librados2-16.2.4-5.el9.x86_64.rp 2.9 MB/s | 3.4 MB     00:01
        (112/123): libvirt-daemon-driver-storage-10  86 kB/s |  28 kB     00:00
        (113/123): qemu-kvm-audio-pa-9.1.0-15.el9_6 222 kB/s |  73 kB     00:00
        (114/123): libvirt-daemon-driver-storage-rb 942 kB/s |  45 kB     00:00
        (115/123): librbd1-16.2.4-5.el9.x86_64.rpm  8.3 MB/s | 3.0 MB     00:00
        (116/123): libvirt-daemon-driver-network-10 744 kB/s | 270 kB     00:00
        (117/123): qemu-kvm-ui-opengl-9.1.0-15.el9_ 221 kB/s |  76 kB     00:00
        (118/123): libvirt-client-qemu-10.10.0-7.6. 903 kB/s |  49 kB     00:00
        (119/123): libfdt-1.6.0-7.el9.x86_64.rpm    439 kB/s |  33 kB     00:00
        (120/123): libvirt-10.10.0-7.6.el9_6.x86_64 477 kB/s |  29 kB     00:00
        (121/123): nbdkit-basic-filters-1.38.5-5.el 3.4 MB/s | 308 kB     00:00
        (122/123): python3-lxml-4.6.5-3.el9.x86_64. 6.6 MB/s | 1.2 MB     00:00
        (123/123): qemu-kvm-common-9.1.0-15.el9_6.7 2.9 MB/s | 668 kB     00:00
        ----------------------------------------------------------------------------
        Total                                       4.6 MB/s |  64 MB     00:13
        Running transaction check
        Transaction check succeeded.
        Running transaction test
        Transaction test succeeded.
        Running transaction
          Preparing        :                                                    1/1
          Installing       : nbdkit-server-1.38.5-5.el9_6.x86_64              1/123
          Installing       : libibverbs-54.0-1.el9.x86_64                     2/123
          Installing       : liburing-2.5-1.el9.x86_64                        3/123
          Installing       : qemu-img-17:9.1.0-15.el9_6.7.x86_64              4/123
          Installing       : librdmacm-54.0-1.el9.x86_64                      5/123
          Installing       : passt-0^20250217.ga1e48a0-10.el9_6.x86_64        6/123
          Running scriptlet: passt-selinux-0^20250217.ga1e48a0-10.el9_6.n     7/123
          Installing       : passt-selinux-0^20250217.ga1e48a0-10.el9_6.n     7/123
          Running scriptlet: passt-selinux-0^20250217.ga1e48a0-10.el9_6.n     7/123
          Installing       : daxctl-libs-78-2.el9.x86_64                      8/123
          Installing       : ndctl-libs-78-2.el9.x86_64                       9/123
          Installing       : libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.    10/123
          Installing       : libnbd-1.20.3-1.el9.x86_64                      11/123
          Installing       : augeas-libs-1.14.1-2.el9.x86_64                 12/123
          Installing       : libnfsidmap-1:2.5.4-34.el9.x86_64               13/123
          Installing       : opennebula-rubygems-6.10.0.1-1.el9.x86_64       14/123
          Running scriptlet: opennebula-rubygems-6.10.0.1-1.el9.x86_64       14/123
          Installing       : augeas-1.14.1-2.el9.x86_64                      15/123
          Installing       : swtpm-libs-0.8.0-2.el9_4.x86_64                 16/123
          Installing       : swtpm-0.8.0-2.el9_4.x86_64                      17/123
          Running scriptlet: swtpm-0.8.0-2.el9_4.x86_64                      17/123
          Installing       : libpmem-1.12.1-1.el9.x86_64                     18/123
          Installing       : libpcap-14:1.10.0-4.el9.x86_64                  19/123
          Installing       : nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64        20/123
          Installing       : nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64         21/123
          Installing       : nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64      22/123
          Installing       : nbdkit-basic-filters-1.38.5-5.el9_6.x86_64      23/123
          Installing       : python3-lxml-4.6.5-3.el9.x86_64                 24/123
          Installing       : libfdt-1.6.0-7.el9.x86_64                       25/123
          Installing       : edk2-ovmf-20241117-2.el9.noarch                 26/123
          Installing       : qemu-kvm-tools-17:9.1.0-15.el9_6.7.x86_64       27/123
          Installing       : mdevctl-1.1.0-4.el9.x86_64                      28/123
          Installing       : libblkio-1.5.0-1.el9_4.x86_64                   29/123
          Installing       : seabios-bin-1.16.3-4.el9.noarch                 30/123
          Installing       : rubygem-rexml-3.2.5-165.el9_5.noarch            31/123
          Installing       : usbredir-0.13.0-2.el9.x86_64                    32/123
          Installing       : boost-iostreams-1.75.0-10.el9.x86_64            33/123
          Installing       : librados2-2:16.2.4-5.el9.x86_64                 34/123
          Running scriptlet: librados2-2:16.2.4-5.el9.x86_64                 34/123
          Installing       : librbd1-2:16.2.4-5.el9.x86_64                   35/123
          Running scriptlet: librbd1-2:16.2.4-5.el9.x86_64                   35/123
          Installing       : capstone-4.0.2-10.el9.x86_64                    36/123
          Installing       : ipxe-roms-qemu-20200823-9.git4bd064de.el9.no    37/123
          Installing       : scrub-2.6.1-4.el9.x86_64                        38/123
          Installing       : qemu-kvm-docs-17:9.1.0-15.el9_6.7.x86_64        39/123
          Installing       : seavgabios-bin-1.16.3-4.el9.noarch              40/123
          Installing       : qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64      41/123
          Running scriptlet: qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64      41/123
          Installing       : qemu-kvm-device-display-virtio-gpu-17:9.1.0-    42/123
          Installing       : qemu-kvm-ui-opengl-17:9.1.0-15.el9_6.7.x86_6    43/123
          Installing       : qemu-kvm-ui-egl-headless-17:9.1.0-15.el9_6.7    44/123
          Installing       : qemu-kvm-device-display-virtio-gpu-pci-17:9.    45/123
          Installing       : qemu-kvm-block-rbd-17:9.1.0-15.el9_6.7.x86_6    46/123
          Installing       : qemu-kvm-device-usb-redirect-17:9.1.0-15.el9    47/123
          Installing       : qemu-kvm-device-display-virtio-vga-17:9.1.0-    48/123
          Installing       : qemu-kvm-device-usb-host-17:9.1.0-15.el9_6.7    49/123
          Installing       : qemu-kvm-block-blkio-17:9.1.0-15.el9_6.7.x86    50/123
          Installing       : qemu-kvm-audio-pa-17:9.1.0-15.el9_6.7.x86_64    51/123
          Running scriptlet: nbdkit-selinux-1.38.5-5.el9_6.noarch            52/123
          Installing       : nbdkit-selinux-1.38.5-5.el9_6.noarch            52/123
          Running scriptlet: nbdkit-selinux-1.38.5-5.el9_6.noarch            52/123
          Installing       : nbdkit-1.38.5-5.el9_6.x86_64                    53/123
          Installing       : virtiofsd-1.13.2-1.el9_6.x86_64                 54/123
          Running scriptlet: dnsmasq-2.85-16.el9_4.x86_64                    55/123
          Installing       : dnsmasq-2.85-16.el9_4.x86_64                    55/123
          Running scriptlet: dnsmasq-2.85-16.el9_4.x86_64                    55/123
          Installing       : libslirp-4.4.0-8.el9.x86_64                     56/123
          Installing       : qemu-kvm-core-17:9.1.0-15.el9_6.7.x86_64        57/123
          Installing       : rsync-3.2.5-3.el9.x86_64                        58/123
          Installing       : pciutils-3.7.0-7.el9.x86_64                     59/123
          Running scriptlet: rpcbind-1.2.6-7.el9.x86_64                      60/123
          Installing       : rpcbind-1.2.6-7.el9.x86_64                      60/123
          Running scriptlet: rpcbind-1.2.6-7.el9.x86_64                      60/123
        Created symlink /etc/systemd/system/multi-user.target.wants/rpcbind.service → /usr/lib/systemd/system/rpcbind.service.
        Created symlink /etc/systemd/system/sockets.target.wants/rpcbind.socket → /usr/lib/systemd/system/rpcbind.socket.
        
          Installing       : systemd-container-252-51.el9_6.1.x86_64         61/123
          Installing       : libev-4.33-6.el9.x86_64                         62/123
          Installing       : libverto-libev-0.3.2-3.el9.x86_64               63/123
          Installing       : gssproxy-0.8.4-7.el9.x86_64                     64/123
          Running scriptlet: gssproxy-0.8.4-7.el9.x86_64                     64/123
          Installing       : dmidecode-1:3.6-1.el9.x86_64                    65/123
          Installing       : quota-nls-1:4.09-4.el9.noarch                   66/123
          Installing       : quota-1:4.09-4.el9.x86_64                       67/123
          Installing       : python3-ply-3.11-14.el9.0.1.noarch              68/123
          Installing       : python3-pycparser-2.20-6.el9.noarch             69/123
          Installing       : python3-cffi-1.14.5-5.el9.x86_64                70/123
          Installing       : python3-cryptography-36.0.1-4.el9.x86_64        71/123
          Installing       : device-mapper-multipath-libs-0.8.7-35.el9_6.    72/123
          Installing       : qemu-pr-helper-17:9.1.0-15.el9_6.7.x86_64       73/123
          Installing       : qemu-kvm-17:9.1.0-15.el9_6.7.x86_64             74/123
          Installing       : cyrus-sasl-gssapi-2.1.27-21.el9.x86_64          75/123
          Installing       : libvirt-libs-10.10.0-7.6.el9_6.x86_64           76/123
          Running scriptlet: libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64    77/123
          Installing       : libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64    77/123
          Running scriptlet: libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64     78/123
          Installing       : libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64     78/123
          Installing       : libvirt-client-10.10.0-7.6.el9_6.x86_64         79/123
          Running scriptlet: libvirt-daemon-common-10.10.0-7.6.el9_6.x86_    80/123
          Installing       : libvirt-daemon-common-10.10.0-7.6.el9_6.x86_    80/123
          Running scriptlet: libvirt-daemon-driver-nwfilter-10.10.0-7.6.e    81/123
          Installing       : libvirt-daemon-driver-nwfilter-10.10.0-7.6.e    81/123
          Running scriptlet: libvirt-daemon-driver-network-10.10.0-7.6.el    82/123
          Installing       : libvirt-daemon-driver-network-10.10.0-7.6.el    82/123
          Running scriptlet: libvirt-daemon-driver-network-10.10.0-7.6.el    82/123
          Running scriptlet: libvirt-daemon-config-network-10.10.0-7.6.el    83/123
          Installing       : libvirt-daemon-config-network-10.10.0-7.6.el    83/123
          Running scriptlet: libvirt-daemon-config-network-10.10.0-7.6.el    83/123
          Running scriptlet: libvirt-daemon-config-nwfilter-10.10.0-7.6.e    84/123
          Installing       : libvirt-daemon-config-nwfilter-10.10.0-7.6.e    84/123
          Running scriptlet: libvirt-daemon-config-nwfilter-10.10.0-7.6.e    84/123
          Running scriptlet: libvirt-daemon-driver-nodedev-10.10.0-7.6.el    85/123
          Installing       : libvirt-daemon-driver-nodedev-10.10.0-7.6.el    85/123
          Running scriptlet: libvirt-daemon-driver-interface-10.10.0-7.6.    86/123
          Installing       : libvirt-daemon-driver-interface-10.10.0-7.6.    86/123
          Running scriptlet: libvirt-daemon-driver-secret-10.10.0-7.6.el9    87/123
          Installing       : libvirt-daemon-driver-secret-10.10.0-7.6.el9    87/123
          Installing       : libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_    88/123
          Installing       : python3-libvirt-10.10.0-1.el9.x86_64            89/123
          Installing       : libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64    90/123
          Installing       : lzop-1.04-8.el9.x86_64                          91/123
          Installing       : python3-pyyaml-5.4.1-6.el9.x86_64               92/123
          Running scriptlet: nfs-utils-1:2.5.4-34.el9.x86_64                 93/123
          Installing       : nfs-utils-1:2.5.4-34.el9.x86_64                 93/123
          Running scriptlet: nfs-utils-1:2.5.4-34.el9.x86_64                 93/123
          Running scriptlet: libvirt-daemon-driver-storage-core-10.10.0-7    94/123
          Installing       : libvirt-daemon-driver-storage-core-10.10.0-7    94/123
          Installing       : libvirt-daemon-driver-storage-mpath-10.10.0-    95/123
          Installing       : libvirt-daemon-driver-storage-logical-10.10.    96/123
          Installing       : libvirt-daemon-driver-storage-disk-10.10.0-7    97/123
          Installing       : libvirt-daemon-driver-storage-scsi-10.10.0-7    98/123
          Installing       : libvirt-daemon-driver-storage-rbd-10.10.0-7.    99/123
          Installing       : numad-0.5-37.20150602git.el9.x86_64            100/123
          Running scriptlet: numad-0.5-37.20150602git.el9.x86_64            100/123
          Installing       : protobuf-c-1.3.3-13.el9.x86_64                 101/123
          Running scriptlet: unbound-libs-1.16.2-19.el9_6.1.x86_64          102/123
          Installing       : unbound-libs-1.16.2-19.el9_6.1.x86_64          102/123
          Running scriptlet: unbound-libs-1.16.2-19.el9_6.1.x86_64          102/123
        Created symlink /etc/systemd/system/timers.target.wants/unbound-anchor.timer → /usr/lib/systemd/system/unbound-anchor.timer.
        
          Installing       : gnutls-dane-3.8.3-6.el9.x86_64                 103/123
          Installing       : gnutls-utils-3.8.3-6.el9.x86_64                104/123
          Installing       : swtpm-tools-0.8.0-2.el9_4.x86_64               105/123
          Running scriptlet: libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6   106/123
          Installing       : libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6   106/123
          Installing       : isns-utils-libs-0.101-4.el9.x86_64             107/123
          Installing       : iscsi-initiator-utils-iscsiuio-6.2.1.9-1.git   108/123
          Running scriptlet: iscsi-initiator-utils-iscsiuio-6.2.1.9-1.git   108/123
        Created symlink /etc/systemd/system/sockets.target.wants/iscsiuio.socket → /usr/lib/systemd/system/iscsiuio.socket.
        
          Installing       : iscsi-initiator-utils-6.2.1.9-1.gita65a472.e   109/123
          Running scriptlet: iscsi-initiator-utils-6.2.1.9-1.gita65a472.e   109/123
        Created symlink /etc/systemd/system/sysinit.target.wants/iscsi-starter.service → /usr/lib/systemd/system/iscsi-starter.service.
        Created symlink /etc/systemd/system/sockets.target.wants/iscsid.socket → /usr/lib/systemd/system/iscsid.socket.
        Created symlink /etc/systemd/system/sysinit.target.wants/iscsi-onboot.service → /usr/lib/systemd/system/iscsi-onboot.service.
        
          Installing       : libvirt-daemon-driver-storage-iscsi-10.10.0-   110/123
          Installing       : libvirt-daemon-driver-storage-10.10.0-7.6.el   111/123
          Running scriptlet: opennebula-common-onecfg-6.10.0.1-1.el9.noar   112/123
          Installing       : opennebula-common-onecfg-6.10.0.1-1.el9.noar   112/123
          Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch        113/123
          Installing       : opennebula-common-6.10.0.1-1.el9.noarch        113/123
          Running scriptlet: opennebula-common-6.10.0.1-1.el9.noarch        113/123
          Installing       : rubygem-sqlite3-1.4.2-8.el9.x86_64             114/123
          Installing       : libretls-3.8.1-1.el9.x86_64                    115/123
          Installing       : libmd-1.1.0-1.el9.x86_64                       116/123
          Installing       : libbsd-0.12.2-1.el9.x86_64                     117/123
          Installing       : netcat-1.229-1.el9.x86_64                      118/123
          Running scriptlet: netcat-1.229-1.el9.x86_64                      118/123
          Running scriptlet: libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_6   119/123
          Installing       : libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_6   119/123
          Running scriptlet: libvirt-daemon-10.10.0-7.6.el9_6.x86_64        120/123
          Installing       : libvirt-daemon-10.10.0-7.6.el9_6.x86_64        120/123
          Installing       : libvirt-10.10.0-7.6.el9_6.x86_64               121/123
          Installing       : opennebula-node-kvm-6.10.0.1-1.el9.noarch      122/123
          Running scriptlet: opennebula-node-kvm-6.10.0.1-1.el9.noarch      122/123
          Installing       : sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64          123/123
          Running scriptlet: passt-selinux-0^20250217.ga1e48a0-10.el9_6.n   123/123
          Running scriptlet: swtpm-0.8.0-2.el9_4.x86_64                     123/123
          Running scriptlet: nbdkit-selinux-1.38.5-5.el9_6.noarch           123/123
          Running scriptlet: libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtlockd.socket → /usr/lib/systemd/system/virtlockd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtlockd-admin.socket → /usr/lib/systemd/system/virtlockd-admin.socket.
        
          Running scriptlet: libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64    123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtlogd.socket → /usr/lib/systemd/system/virtlogd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtlogd-admin.socket → /usr/lib/systemd/system/virtlogd-admin.socket.
        
          Running scriptlet: libvirt-daemon-common-10.10.0-7.6.el9_6.x86_   123/123
          Running scriptlet: libvirt-daemon-driver-nwfilter-10.10.0-7.6.e   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtnwfilterd.socket → /usr/lib/systemd/system/virtnwfilterd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtnwfilterd-ro.socket → /usr/lib/systemd/system/virtnwfilterd-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtnwfilterd-admin.socket → /usr/lib/systemd/system/virtnwfilterd-admin.socket.
        
          Running scriptlet: libvirt-daemon-driver-network-10.10.0-7.6.el   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtnetworkd.socket → /usr/lib/systemd/system/virtnetworkd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtnetworkd-ro.socket → /usr/lib/systemd/system/virtnetworkd-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtnetworkd-admin.socket → /usr/lib/systemd/system/virtnetworkd-admin.socket.
        
          Running scriptlet: libvirt-daemon-config-network-10.10.0-7.6.el   123/123
          Running scriptlet: libvirt-daemon-config-nwfilter-10.10.0-7.6.e   123/123
          Running scriptlet: libvirt-daemon-driver-nodedev-10.10.0-7.6.el   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtnodedevd.socket → /usr/lib/systemd/system/virtnodedevd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtnodedevd-ro.socket → /usr/lib/systemd/system/virtnodedevd-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtnodedevd-admin.socket → /usr/lib/systemd/system/virtnodedevd-admin.socket.
        
          Running scriptlet: libvirt-daemon-driver-interface-10.10.0-7.6.   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtinterfaced.socket → /usr/lib/systemd/system/virtinterfaced.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtinterfaced-ro.socket → /usr/lib/systemd/system/virtinterfaced-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtinterfaced-admin.socket → /usr/lib/systemd/system/virtinterfaced-admin.socket.
        
          Running scriptlet: libvirt-daemon-driver-secret-10.10.0-7.6.el9   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtsecretd.socket → /usr/lib/systemd/system/virtsecretd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtsecretd-ro.socket → /usr/lib/systemd/system/virtsecretd-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtsecretd-admin.socket → /usr/lib/systemd/system/virtsecretd-admin.socket.
        
          Running scriptlet: libvirt-daemon-driver-storage-core-10.10.0-7   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtstoraged.socket → /usr/lib/systemd/system/virtstoraged.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtstoraged-ro.socket → /usr/lib/systemd/system/virtstoraged-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtstoraged-admin.socket → /usr/lib/systemd/system/virtstoraged-admin.socket.
        
          Running scriptlet: libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtqemud.socket → /usr/lib/systemd/system/virtqemud.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtqemud-ro.socket → /usr/lib/systemd/system/virtqemud-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtqemud-admin.socket → /usr/lib/systemd/system/virtqemud-admin.socket.
        Created symlink /etc/systemd/system/multi-user.target.wants/virtqemud.service → /usr/lib/systemd/system/virtqemud.service.
        
          Running scriptlet: libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_6   123/123
        Created symlink /etc/systemd/system/sockets.target.wants/virtproxyd.socket → /usr/lib/systemd/system/virtproxyd.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtproxyd-ro.socket → /usr/lib/systemd/system/virtproxyd-ro.socket.
        Created symlink /etc/systemd/system/sockets.target.wants/virtproxyd-admin.socket → /usr/lib/systemd/system/virtproxyd-admin.socket.
        
          Running scriptlet: libvirt-daemon-10.10.0-7.6.el9_6.x86_64        123/123
          Running scriptlet: sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64          123/123
        /usr/lib/sysusers.d/libvirt-qemu.conf:1: Conflict with earlier configuration for group 'kvm', ignoring line.
        
        Couldn't write '1' to 'net/bridge/bridge-nf-call-arptables', ignoring: No such file or directory
        Couldn't write '1' to 'net/bridge/bridge-nf-call-ip6tables', ignoring: No such file or directory
        Couldn't write '1' to 'net/bridge/bridge-nf-call-iptables', ignoring: No such file or directory
        
          Verifying        : libbsd-0.12.2-1.el9.x86_64                       1/123
          Verifying        : libmd-1.1.0-1.el9.x86_64                         2/123
          Verifying        : libretls-3.8.1-1.el9.x86_64                      3/123
          Verifying        : netcat-1.229-1.el9.x86_64                        4/123
          Verifying        : rubygem-sqlite3-1.4.2-8.el9.x86_64               5/123
          Verifying        : opennebula-common-6.10.0.1-1.el9.noarch          6/123
          Verifying        : opennebula-common-onecfg-6.10.0.1-1.el9.noar     7/123
          Verifying        : opennebula-node-kvm-6.10.0.1-1.el9.noarch        8/123
          Verifying        : opennebula-rubygems-6.10.0.1-1.el9.x86_64        9/123
          Verifying        : python3-pycparser-2.20-6.el9.noarch             10/123
          Verifying        : isns-utils-libs-0.101-4.el9.x86_64              11/123
          Verifying        : protobuf-c-1.3.3-13.el9.x86_64                  12/123
          Verifying        : sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64           13/123
          Verifying        : numad-0.5-37.20150602git.el9.x86_64             14/123
          Verifying        : python3-pyyaml-5.4.1-6.el9.x86_64               15/123
          Verifying        : iscsi-initiator-utils-6.2.1.9-1.gita65a472.e    16/123
          Verifying        : python3-cryptography-36.0.1-4.el9.x86_64        17/123
          Verifying        : lzop-1.04-8.el9.x86_64                          18/123
          Verifying        : librdmacm-54.0-1.el9.x86_64                     19/123
          Verifying        : cyrus-sasl-gssapi-2.1.27-21.el9.x86_64          20/123
          Verifying        : device-mapper-multipath-libs-0.8.7-35.el9_6.    21/123
          Verifying        : quota-1:4.09-4.el9.x86_64                       22/123
          Verifying        : python3-ply-3.11-14.el9.0.1.noarch              23/123
          Verifying        : iscsi-initiator-utils-iscsiuio-6.2.1.9-1.git    24/123
          Verifying        : quota-nls-1:4.09-4.el9.noarch                   25/123
          Verifying        : gssproxy-0.8.4-7.el9.x86_64                     26/123
          Verifying        : dmidecode-1:3.6-1.el9.x86_64                    27/123
          Verifying        : ndctl-libs-78-2.el9.x86_64                      28/123
          Verifying        : libibverbs-54.0-1.el9.x86_64                    29/123
          Verifying        : libev-4.33-6.el9.x86_64                         30/123
          Verifying        : libverto-libev-0.3.2-3.el9.x86_64               31/123
          Verifying        : python3-cffi-1.14.5-5.el9.x86_64                32/123
          Verifying        : libpcap-14:1.10.0-4.el9.x86_64                  33/123
          Verifying        : nfs-utils-1:2.5.4-34.el9.x86_64                 34/123
          Verifying        : systemd-container-252-51.el9_6.1.x86_64         35/123
          Verifying        : rpcbind-1.2.6-7.el9.x86_64                      36/123
          Verifying        : pciutils-3.7.0-7.el9.x86_64                     37/123
          Verifying        : libnfsidmap-1:2.5.4-34.el9.x86_64               38/123
          Verifying        : daxctl-libs-78-2.el9.x86_64                     39/123
          Verifying        : rsync-3.2.5-3.el9.x86_64                        40/123
          Verifying        : libslirp-4.4.0-8.el9.x86_64                     41/123
          Verifying        : libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_    42/123
          Verifying        : dnsmasq-2.85-16.el9_4.x86_64                    43/123
          Verifying        : libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_6    44/123
          Verifying        : passt-selinux-0^20250217.ga1e48a0-10.el9_6.n    45/123
          Verifying        : virtiofsd-1.13.2-1.el9_6.x86_64                 46/123
          Verifying        : libvirt-daemon-10.10.0-7.6.el9_6.x86_64         47/123
          Verifying        : libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64    48/123
          Verifying        : libvirt-libs-10.10.0-7.6.el9_6.x86_64           49/123
          Verifying        : swtpm-0.8.0-2.el9_4.x86_64                      50/123
          Verifying        : swtpm-tools-0.8.0-2.el9_4.x86_64                51/123
          Verifying        : nbdkit-selinux-1.38.5-5.el9_6.noarch            52/123
          Verifying        : libvirt-daemon-driver-nodedev-10.10.0-7.6.el    53/123
          Verifying        : passt-0^20250217.ga1e48a0-10.el9_6.x86_64       54/123
          Verifying        : qemu-kvm-block-rbd-17:9.1.0-15.el9_6.7.x86_6    55/123
          Verifying        : libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64     56/123
          Verifying        : augeas-libs-1.14.1-2.el9.x86_64                 57/123
          Verifying        : libnbd-1.20.3-1.el9.x86_64                      58/123
          Verifying        : libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.    59/123
          Verifying        : seavgabios-bin-1.16.3-4.el9.noarch              60/123
          Verifying        : liburing-2.5-1.el9.x86_64                       61/123
          Verifying        : nbdkit-server-1.38.5-5.el9_6.x86_64             62/123
          Verifying        : libvirt-daemon-config-network-10.10.0-7.6.el    63/123
          Verifying        : qemu-kvm-docs-17:9.1.0-15.el9_6.7.x86_64        64/123
          Verifying        : scrub-2.6.1-4.el9.x86_64                        65/123
          Verifying        : qemu-kvm-device-display-virtio-gpu-17:9.1.0-    66/123
          Verifying        : libvirt-daemon-driver-storage-mpath-10.10.0-    67/123
          Verifying        : libvirt-daemon-driver-storage-core-10.10.0-7    68/123
          Verifying        : qemu-kvm-device-usb-redirect-17:9.1.0-15.el9    69/123
          Verifying        : libvirt-daemon-driver-storage-iscsi-10.10.0-    70/123
          Verifying        : libvirt-client-10.10.0-7.6.el9_6.x86_64         71/123
          Verifying        : ipxe-roms-qemu-20200823-9.git4bd064de.el9.no    72/123
          Verifying        : libvirt-daemon-driver-nwfilter-10.10.0-7.6.e    73/123
          Verifying        : capstone-4.0.2-10.el9.x86_64                    74/123
          Verifying        : libvirt-daemon-driver-storage-logical-10.10.    75/123
          Verifying        : nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64        76/123
          Verifying        : qemu-kvm-ui-egl-headless-17:9.1.0-15.el9_6.7    77/123
          Verifying        : qemu-kvm-core-17:9.1.0-15.el9_6.7.x86_64        78/123
          Verifying        : qemu-kvm-17:9.1.0-15.el9_6.7.x86_64             79/123
          Verifying        : qemu-pr-helper-17:9.1.0-15.el9_6.7.x86_64       80/123
          Verifying        : libpmem-1.12.1-1.el9.x86_64                     81/123
          Verifying        : gnutls-dane-3.8.3-6.el9.x86_64                  82/123
          Verifying        : augeas-1.14.1-2.el9.x86_64                      83/123
          Verifying        : swtpm-libs-0.8.0-2.el9_4.x86_64                 84/123
          Verifying        : libvirt-daemon-common-10.10.0-7.6.el9_6.x86_    85/123
          Verifying        : qemu-img-17:9.1.0-15.el9_6.7.x86_64             86/123
          Verifying        : libvirt-daemon-driver-storage-disk-10.10.0-7    87/123
          Verifying        : unbound-libs-1.16.2-19.el9_6.1.x86_64           88/123
          Verifying        : nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64         89/123
          Verifying        : qemu-kvm-device-display-virtio-vga-17:9.1.0-    90/123
          Verifying        : boost-iostreams-1.75.0-10.el9.x86_64            91/123
          Verifying        : libvirt-daemon-driver-interface-10.10.0-7.6.    92/123
          Verifying        : usbredir-0.13.0-2.el9.x86_64                    93/123
          Verifying        : rubygem-rexml-3.2.5-165.el9_5.noarch            94/123
          Verifying        : qemu-kvm-device-usb-host-17:9.1.0-15.el9_6.7    95/123
          Verifying        : qemu-kvm-device-display-virtio-gpu-pci-17:9.    96/123
          Verifying        : seabios-bin-1.16.3-4.el9.noarch                 97/123
          Verifying        : nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64      98/123
          Verifying        : gnutls-utils-3.8.3-6.el9.x86_64                 99/123
          Verifying        : libvirt-daemon-config-nwfilter-10.10.0-7.6.e   100/123
          Verifying        : qemu-kvm-block-blkio-17:9.1.0-15.el9_6.7.x86   101/123
          Verifying        : libvirt-daemon-driver-secret-10.10.0-7.6.el9   102/123
          Verifying        : libblkio-1.5.0-1.el9_4.x86_64                  103/123
          Verifying        : mdevctl-1.1.0-4.el9.x86_64                     104/123
          Verifying        : python3-libvirt-10.10.0-1.el9.x86_64           105/123
          Verifying        : libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6   106/123
          Verifying        : libvirt-daemon-driver-storage-scsi-10.10.0-7   107/123
          Verifying        : qemu-kvm-tools-17:9.1.0-15.el9_6.7.x86_64      108/123
          Verifying        : edk2-ovmf-20241117-2.el9.noarch                109/123
          Verifying        : nbdkit-1.38.5-5.el9_6.x86_64                   110/123
          Verifying        : librados2-2:16.2.4-5.el9.x86_64                111/123
          Verifying        : libvirt-daemon-driver-storage-10.10.0-7.6.el   112/123
          Verifying        : qemu-kvm-audio-pa-17:9.1.0-15.el9_6.7.x86_64   113/123
          Verifying        : libvirt-daemon-driver-storage-rbd-10.10.0-7.   114/123
          Verifying        : librbd1-2:16.2.4-5.el9.x86_64                  115/123
          Verifying        : libvirt-daemon-driver-network-10.10.0-7.6.el   116/123
          Verifying        : qemu-kvm-ui-opengl-17:9.1.0-15.el9_6.7.x86_6   117/123
          Verifying        : libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64   118/123
          Verifying        : libfdt-1.6.0-7.el9.x86_64                      119/123
          Verifying        : libvirt-10.10.0-7.6.el9_6.x86_64               120/123
          Verifying        : nbdkit-basic-filters-1.38.5-5.el9_6.x86_64     121/123
          Verifying        : python3-lxml-4.6.5-3.el9.x86_64                122/123
          Verifying        : qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64     123/123
        
        Installed:
          augeas-1.14.1-2.el9.x86_64
          augeas-libs-1.14.1-2.el9.x86_64
          boost-iostreams-1.75.0-10.el9.x86_64
          capstone-4.0.2-10.el9.x86_64
          cyrus-sasl-gssapi-2.1.27-21.el9.x86_64
          daxctl-libs-78-2.el9.x86_64
          device-mapper-multipath-libs-0.8.7-35.el9_6.1.x86_64
          dmidecode-1:3.6-1.el9.x86_64
          dnsmasq-2.85-16.el9_4.x86_64
          edk2-ovmf-20241117-2.el9.noarch
          gnutls-dane-3.8.3-6.el9.x86_64
          gnutls-utils-3.8.3-6.el9.x86_64
          gssproxy-0.8.4-7.el9.x86_64
          ipxe-roms-qemu-20200823-9.git4bd064de.el9.noarch
          iscsi-initiator-utils-6.2.1.9-1.gita65a472.el9.x86_64
          iscsi-initiator-utils-iscsiuio-6.2.1.9-1.gita65a472.el9.x86_64
          isns-utils-libs-0.101-4.el9.x86_64
          libblkio-1.5.0-1.el9_4.x86_64
          libbsd-0.12.2-1.el9.x86_64
          libev-4.33-6.el9.x86_64
          libfdt-1.6.0-7.el9.x86_64
          libibverbs-54.0-1.el9.x86_64
          libmd-1.1.0-1.el9.x86_64
          libnbd-1.20.3-1.el9.x86_64
          libnfsidmap-1:2.5.4-34.el9.x86_64
          libpcap-14:1.10.0-4.el9.x86_64
          libpmem-1.12.1-1.el9.x86_64
          librados2-2:16.2.4-5.el9.x86_64
          librbd1-2:16.2.4-5.el9.x86_64
          librdmacm-54.0-1.el9.x86_64
          libretls-3.8.1-1.el9.x86_64
          libslirp-4.4.0-8.el9.x86_64
          libtpms-0.9.1-5.20211126git1ff6fe1f43.el9_6.x86_64
          liburing-2.5-1.el9.x86_64
          libverto-libev-0.3.2-3.el9.x86_64
          libvirt-10.10.0-7.6.el9_6.x86_64
          libvirt-client-10.10.0-7.6.el9_6.x86_64
          libvirt-client-qemu-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-common-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-config-network-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-config-nwfilter-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-interface-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-network-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-nodedev-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-nwfilter-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-qemu-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-secret-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-core-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-disk-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-iscsi-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-logical-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-mpath-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-rbd-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-driver-storage-scsi-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-lock-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-log-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-plugin-lockd-10.10.0-7.6.el9_6.x86_64
          libvirt-daemon-proxy-10.10.0-7.6.el9_6.x86_64
          libvirt-libs-10.10.0-7.6.el9_6.x86_64
          lzop-1.04-8.el9.x86_64
          mdevctl-1.1.0-4.el9.x86_64
          nbdkit-1.38.5-5.el9_6.x86_64
          nbdkit-basic-filters-1.38.5-5.el9_6.x86_64
          nbdkit-basic-plugins-1.38.5-5.el9_6.x86_64
          nbdkit-curl-plugin-1.38.5-5.el9_6.x86_64
          nbdkit-selinux-1.38.5-5.el9_6.noarch
          nbdkit-server-1.38.5-5.el9_6.x86_64
          nbdkit-ssh-plugin-1.38.5-5.el9_6.x86_64
          ndctl-libs-78-2.el9.x86_64
          netcat-1.229-1.el9.x86_64
          nfs-utils-1:2.5.4-34.el9.x86_64
          numad-0.5-37.20150602git.el9.x86_64
          opennebula-common-6.10.0.1-1.el9.noarch
          opennebula-common-onecfg-6.10.0.1-1.el9.noarch
          opennebula-node-kvm-6.10.0.1-1.el9.noarch
          opennebula-rubygems-6.10.0.1-1.el9.x86_64
          passt-0^20250217.ga1e48a0-10.el9_6.x86_64
          passt-selinux-0^20250217.ga1e48a0-10.el9_6.noarch
          pciutils-3.7.0-7.el9.x86_64
          protobuf-c-1.3.3-13.el9.x86_64
          python3-cffi-1.14.5-5.el9.x86_64
          python3-cryptography-36.0.1-4.el9.x86_64
          python3-libvirt-10.10.0-1.el9.x86_64
          python3-lxml-4.6.5-3.el9.x86_64
          python3-ply-3.11-14.el9.0.1.noarch
          python3-pycparser-2.20-6.el9.noarch
          python3-pyyaml-5.4.1-6.el9.x86_64
          qemu-img-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-audio-pa-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-block-blkio-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-block-rbd-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-common-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-core-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-device-display-virtio-gpu-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-device-display-virtio-gpu-pci-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-device-display-virtio-vga-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-device-usb-host-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-device-usb-redirect-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-docs-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-tools-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-ui-egl-headless-17:9.1.0-15.el9_6.7.x86_64
          qemu-kvm-ui-opengl-17:9.1.0-15.el9_6.7.x86_64
          qemu-pr-helper-17:9.1.0-15.el9_6.7.x86_64
          quota-1:4.09-4.el9.x86_64
          quota-nls-1:4.09-4.el9.noarch
          rpcbind-1.2.6-7.el9.x86_64
          rsync-3.2.5-3.el9.x86_64
          rubygem-rexml-3.2.5-165.el9_5.noarch
          rubygem-sqlite3-1.4.2-8.el9.x86_64
          scrub-2.6.1-4.el9.x86_64
          seabios-bin-1.16.3-4.el9.noarch
          seavgabios-bin-1.16.3-4.el9.noarch
          sssd-nfs-idmap-2.9.6-4.el9_6.2.x86_64
          swtpm-0.8.0-2.el9_4.x86_64
          swtpm-libs-0.8.0-2.el9_4.x86_64
          swtpm-tools-0.8.0-2.el9_4.x86_64
          systemd-container-252-51.el9_6.1.x86_64
          unbound-libs-1.16.2-19.el9_6.1.x86_64
          usbredir-0.13.0-2.el9.x86_64
          virtiofsd-1.13.2-1.el9_6.x86_64
        
        Complete!
#### 🌞 Dépendances additionnelles

       [root@kvm1 ~]# dnf install -y genisoimage
    Last metadata expiration check: 3:12:05 ago on Wed Sep 17 11:51:56 2025.
    Dependencies resolved.
    ============================================================================
     Package            Architecture  Version                 Repository   Size
    ============================================================================
    Installing:
     genisoimage        x86_64        1.1.11-48.el9           epel        324 k
    Installing dependencies:
     libusal            x86_64        1.1.11-48.el9           epel        137 k
    
    Transaction Summary
    ============================================================================
    Install  2 Packages
    
    Total download size: 461 k
    Installed size: 1.6 M
    Downloading Packages:
    (1/2): libusal-1.1.11-48.el9.x86_64.rpm     487 kB/s | 137 kB     00:00
    (2/2): genisoimage-1.1.11-48.el9.x86_64.rpm 721 kB/s | 324 kB     00:00
    ----------------------------------------------------------------------------
    Total                                       379 kB/s | 461 kB     00:01
    Running transaction check
    Transaction check succeeded.
    Running transaction test
    Transaction test succeeded.
    Running transaction
      Preparing        :                                                    1/1
      Installing       : libusal-1.1.11-48.el9.x86_64                       1/2
      Installing       : genisoimage-1.1.11-48.el9.x86_64                   2/2
      Running scriptlet: genisoimage-1.1.11-48.el9.x86_64                   2/2
      Verifying        : genisoimage-1.1.11-48.el9.x86_64                   1/2
      Verifying        : libusal-1.1.11-48.el9.x86_64                       2/2
    
    Installed:
      genisoimage-1.1.11-48.el9.x86_64       libusal-1.1.11-48.el9.x86_64


#### 🌞 Démarrer le service libvirtd

       [root@kvm1 ~]# sudo systemctl start libvirtd
    [root@kvm1 ~]# sudo systemctl enable libvirtd
    Created symlink /etc/systemd/system/multi-user.target.wants/libvirtd.service → /usr/lib/systemd/system/libvirtd.service.
    Created symlink /etc/systemd/system/sockets.target.wants/libvirtd.socket → /usr/lib/systemd/system/libvirtd.socket.
    Created symlink /etc/systemd/system/sockets.target.wants/libvirtd-ro.socket → /usr/lib/systemd/system/libvirtd-ro.socket.
    Created symlink /etc/systemd/system/sockets.target.wants/libvirtd-admin.socket → /usr/lib/systemd/system/libvirtd-admin.socket.
    [root@kvm1 ~]# sudo systemctl status libvirtd
    ● libvirtd.service - libvirt legacy monolithic daemon
         Loaded: loaded (/usr/lib/systemd/system/libvirtd.service; enabled; pre>
         Active: active (running) since Wed 2025-09-17 15:08:32 CEST; 29s ago
    TriggeredBy: ● libvirtd.socket
                 ● libvirtd-ro.socket
                 ● libvirtd-admin.socket
           Docs: man:libvirtd(8)
                 https://libvirt.org/
       Main PID: 7748 (libvirtd)
          Tasks: 22 (limit: 32768)
         Memory: 22.9M
            CPU: 1.020s
         CGroup: /system.slice/libvirtd.service
                 ├─7748 /usr/sbin/libvirtd --timeout 120
                 ├─7850 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/>
                 └─7851 /usr/sbin/dnsmasq --conf-file=/var/lib/libvirt/dnsmasq/>
    
    Sep 17 15:08:32 kvm1.one dnsmasq-dhcp[7850]: DHCP, sockets bound exclusivel>
    Sep 17 15:08:32 kvm1.one dnsmasq[7850]: reading /etc/resolv.conf
    Sep 17 15:08:32 kvm1.one dnsmasq[7850]: using nameserver 192.168.110.2#53
    Sep 17 15:08:32 kvm1.one dnsmasq[7850]: using nameserver 1.1.1.1#53
    Sep 17 15:08:32 kvm1.one dnsmasq[7850]: read /etc/hosts - 5 addresses
    Sep 17 15:08:32 kvm1.one dnsmasq[7850]: read /var/lib/libvirt/dnsmasq/defau>
    Sep 17 15:08:32 kvm1.one dnsmasq-dhcp[7850]: read /var/lib/libvirt/dnsmasq/>
    Sep 17 15:08:33 kvm1.one libvirtd[7748]: libvirt version: 10.10.0, package:>
    Sep 17 15:08:33 kvm1.one libvirtd[7748]: hostname: kvm1.one
    Sep 17 15:08:33 kvm1.one libvirtd[7748]: Unable to open /dev/kvm: No such f>
    lines 1-27/27 (END)
    
### B. Système
#### 🌞 Ouverture firewall

    [root@kvm1 ~]# sudo firewall-cmd --permanent --add-port=22/tcp
    success
    [root@kvm1 ~]# sudo firewall-cmd --permanent --add-port=8472/udp
    success
    [root@kvm1 ~]# sudo firewall-cmd --reload
    success

#### 🌞 Handle SSH

  uniquement pour ce point, repassez en SSH sur frontend.one
  OpenNebula reposant sur des connexions SSH, elles doivent toutes se passer sans interaction humaine (pas de demande d'acceptation d'empreintes, ni de passwords par exemple)

  donc, en étant connecté en tant que oneadmin sur frontend.one
  les commandes doivent fonctionner sans aucun prompt (ni password, ni empreinte) :
  
    [oneadmin@frontend ~]$ ssh oneadmin@frontend.one
    Last login: Wed Sep 17 12:42:00 2025
    [oneadmin@frontend ~]$

    [oneadmin@frontend ~]$ ssh oneadmin@kvm1.one
    Last login: Tue Sep 16 22:56:47 2025 from 10.3.1.10
    [oneadmin@kvm1 ~]$
    
### II.3. Setup réseau


### C. Préparer le bridge réseau
➜ Ces étapes sont à effectuer uniquement sur kvm1.one dans un premier temps

dans la partie IV du TP, quand vous mettrez en place kvm2.one, il faudra aussi refaire ça dessus
#### 🌞 Créer et configurer le bridge Linux, j'vous file tout, suivez le guide :


    [root@kvm1 ~]# ip link add name vxlan_bridge type bridge
    [root@kvm1 ~]# ip link set dev vxlan_bridge up
    [root@kvm1 ~]# ip addr add 10.220.220.201/24 dev vxlan_bridge
    [root@kvm1 ~]# firewall-cmd --add-interface=vxlan_bridge --zone=public --permanent
    success
    [root@kvm1 ~]# firewall-cmd --add-masquerade --permanent
    success
    [root@kvm1 ~]# firewall-cmd --reload
    success
    
    
    
    [root@kvm1 ~]#



➜ Je vous conseille très fort de faire en sorte que ce script s'exécute automatiquement au démarrage.

En faisant un ptit service systemd par exemple, que vous pouvez enable ensuite :

 on suppose que le script est dans /opt/vxlan.sh

    [root@kvm1 ~]# sudo vim /opt/vxlan.sh
        [root@kvm1 ~]# sudo chmod +x /opt/vxlan.sh
        [root@kvm1 ~]# sudo vim /etc/systemd/system/vxlan.service
        </system/vxlan.service" [New] 10L, 165B written
        [root@kvm1 ~]# sudo systemctl daemon-reload
        [root@kvm1 ~]# sudo systemctl start vxlan
        [root@kvm1 ~]# sudo systemctl enable vxlan
        Created symlink /etc/systemd/system/multi-user.target.wants/vxlan.service → /etc/systemd/system/vxlan.service.
    
    
    [root@kvm1 ~]# ip addr show vxlan_bridge
    5: vxlan_bridge: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UNKNOWN group default qlen 1000
        link/ether fa:54:f6:4b:a6:38 brd ff:ff:ff:ff:ff:ff
        inet 10.220.220.201/24 scope global vxlan_bridge
           valid_lft forever preferred_lft forever
        inet6 fe80::f854:f6ff:fe4b:a638/64 scope link
           valid_lft forever preferred_lft forever
           
    [root@kvm1 ~]# firewall-cmd --list-all
    public (active)
      target: default
      icmp-block-inversion: no
      interfaces: ens160 ens192 vxlan_bridge
      sources:
      services: cockpit dhcpv6-client ssh
      ports: 9869/tcp 22/tcp 2633/tcp 4124/tcp 4124/udp 29876/tcp 8472/udp
      protocols:
      forward: yes
      masquerade: yes
      forward-ports:
      source-ports:
      icmp-blocks:
      rich rules:


### III. Utiliser la plateforme

  ➜ Tester la connectivité à la VM

déjà est-ce qu'on peut la ping ? Oui j'arrive a la ping!!

depuis le noeud kvm1.one, faites un ping vers l'IP de la VM
l'IP de la VM est visible dans la WebUI

    [root@kvm1 ~]# ping 10.220.220.1
    PING 10.220.220.1 (10.220.220.1) 56(84) bytes of data.
    64 bytes from 10.220.220.1: icmp_seq=1 ttl=64 time=0.668 ms
    64 bytes from 10.220.220.1: icmp_seq=2 ttl=64 time=0.799 ms
    64 bytes from 10.220.220.1: icmp_seq=3 ttl=64 time=0.568 ms
    64 bytes from 10.220.220.1: icmp_seq=4 ttl=64 time=1.13 ms
    ^C
    --- 10.220.220.1 ping statistics ---
    4 packets transmitted, 4 received, 0% packet loss, time 3038ms
    rtt min/avg/max/mdev = 0.568/0.792/1.134/0.213 ms

  
pour pouvoir se co en SSH, il faut utiliser la clé de oneadmin, suivez le guide :

    [oneadmin@frontend ~]$ eval $(ssh-agent)
    Agent pid xxxx
    
    [oneadmin@frontend ~]$ ssh-add
    Identity added: /var/lib/one/.ssh/id_rsa (oneadmin@frontend.one)
    
    [oneadmin@frontend ~]$ ssh -J kvm1.one root@10.220.220.1
    Activate the web console with: systemctl enable --now cockpit.socket
    
    Last login: Wed Sep 17 14:05:48 2025 from 10.220.220.201
    [root@localhost ~]#


➜ Si vous avez bien un shell dans la VM, vous êtes au bout des péripéties, pour un setup basique !

vous pouvez éventuellement ajouter l'IP de la machine hôte comme route par défaut pour avoir internet (l'IP du bridge VXLAN de l'hôte) :


    [root@localhost ~]# ip route add default via 10.220.220.201
    
    [root@localhost ~]# ping 1.1.1.1
    PING 1.1.1.1 (1.1.1.1) 56(84) bytes of data.
    64 bytes from 1.1.1.1: icmp_seq=1 ttl=127 time=23.4 ms
    64 bytes from 1.1.1.1: icmp_seq=2 ttl=127 time=17.0 ms
    ^C
    --- 1.1.1.1 ping statistics ---
    2 packets transmitted, 2 received, 0% packet loss, time 1002ms
    rtt min/avg/max/mdev = 17.012/20.203/23.394/3.191 ms
    [root@localhost ~]#


### IV. Ajout d'un noeud et VXLAN
Dernière partie : on configure kvm2.one et on teste les fonctionnalités réseau VXLAN : deux VMs sur des hyperviseurs différents se ping comme si elles étaient dans le même LAN !

### 1. Ajout d'un noeud
#### 🌞 Setup de kvm2.one, à l'identique de kvm1.one excepté :

une autre IP statique bien sûr

    [root@kvm2 ~]# ip a
    1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
        link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
        inet 127.0.0.1/8 scope host lo
           valid_lft forever preferred_lft forever
        inet6 ::1/128 scope host
           valid_lft forever preferred_lft forever
    2: ens160: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether 00:0c:29:a7:1a:8e brd ff:ff:ff:ff:ff:ff
        altname enp3s0
        inet 192.168.110.144/24 brd 192.168.110.255 scope global dynamic noprefixroute ens160
           valid_lft 1157sec preferred_lft 1157sec
        inet6 fe80::20c:29ff:fea7:1a8e/64 scope link noprefixroute
           valid_lft forever preferred_lft forever
    3: ens192: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
        link/ether 00:0c:29:a7:1a:98 brd ff:ff:ff:ff:ff:ff
        altname enp11s0
        inet 10.3.1.12/24 brd 10.3.1.255 scope global noprefixroute ens192
           valid_lft forever preferred_lft forever
    4: virbr0: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc noqueue state DOWN group default qlen 1000
        link/ether 52:54:00:f4:8b:e5 brd ff:ff:ff:ff:ff:ff
        inet 192.168.122.1/24 brd 192.168.122.255 scope global virbr0
           valid_lft forever preferred_lft forever
    
idem, pour le bridge, donnez-lui l'IP 10.220.220.202/24 (celle qui est juste après l'IP du bridge de kvm1)

    [root@kvm2 ~]# ip link add name vxlan_bridge type bridge
    [root@kvm2 ~]# ip link set dev vxlan_bridge up
    [root@kvm2 ~]# ip addr add 10.220.220.202/24 dev vxlan_bridge
    [root@kvm2 ~]# firewall-cmd --add-interface=vxlan_bridge --zone=public --permanent
    success
    [root@kvm2 ~]# firewall-cmd --add-masquerade --permanent
    success
    [root@kvm2 ~]# firewall-cmd --reload
    success
    [root@kvm2 ~]#

une fois setup, ajoutez le dans la WebUI, dans Infrastructure > Hosts  ( c'est fait !!!)


### 2. VM sur le deuxième noeud
#### 🌞 Lancer une deuxième VM

vous pouvez la forcer à tourner sur kvm2.one lors de sa création
mettez la dans le même réseau que le premier kvm1.one
assurez-vous que vous pouvez vous y connecter en SSH

            [oneadmin@frontend ~]$  ssh -J kvm2.one root@10.220.220.2
            Activate the web console with: systemctl enable --now cockpit.socket
            
            Last failed login: Sat Sep 20 23:42:31 UTC 2025 from 10.220.220.202 on ssh:notty
            There were 3 failed login attempts since the last successful login.
            [root@localhost ~]#

### 3. Connectivité entre les VMs
#### 🌞 Les deux VMs doivent pouvoir se ping

alors qu'elles sont sur des hyperviseurs différents, elles se ping comme si elles étaient dans le même réseau local !


            [root@localhost ~]# ping 10.220.220.4
            PING 10.220.220.4 (10.220.220.4) 56(84) bytes of data.
            64 bytes from 10.220.220.4: icmp_seq=1 ttl=64 time=10.7 ms
            64 bytes from 10.220.220.4: icmp_seq=2 ttl=64 time=2.51 ms
            64 bytes from 10.220.220.4: icmp_seq=3 ttl=64 time=1.81 ms
            64 bytes from 10.220.220.4: icmp_seq=4 ttl=64 time=5.91 ms
            
            --- 10.220.220.4 ping statistics ---
            4 packets transmitted, 4 received, 0% packet loss, time 3017ms^C
            rtt min/avg/max/mdev = 1.808/5.220/10.654/3.499 ms
            [root@localhost ~]#
            ---------------------------------------------------------------------------------

            [oneadmin@frontend ~]$ ssh -J kvm1.one root@10.220.220.4
            Warning: Permanently added '10.220.220.4' (ED25519) to the list of known hosts.
            Activate the web console with: systemctl enable -- now cockpit.socket
            
            [root@localhost ~]# ping 10.220.220.3
            PING 10.220.220.3 (10.220.220.3) 56(84) bytes of data.
            64 bytes from 10.220.220.3: icmp_seq=1 ttl=64 time=7.16 ms
            64 bytes from 10.220.220.3: icmp_seq=2 ttl=64 time=2.98 ms
            
            10.220.220.3 ping statistics
            2 packets transmitted, 2 received, 0% packet loss, time 1013ms
            rtt min/avg/max/mdev = 2.978/5.068/7.158/2.090 ms
            [root@localhost ~l#


### 4. Inspection du trafic
#### 🌞 Téléchargez tcpdump sur l'un des noeuds KVM

            [root@kvm1 ~]# sudo dnf install tcpdump -y
            Rocky Linux 9 - BaseOS                       14 kB/s | 4.1 kB     00:00
            Rocky Linux 9 - AppStream                    18 kB/s | 4.5 kB     00:00
            Rocky Linux 9 - Extras                      8.9 kB/s | 2.9 kB     00:00
            Dependencies resolved.
            ============================================================================
             Package        Architecture  Version                Repository        Size
            ============================================================================
            Installing:
             tcpdump        x86_64        14:4.99.0-9.el9        appstream        542 k
            
            Transaction Summary
            ============================================================================
            Install  1 Package
            
            Total download size: 542 k
            Installed size: 1.4 M
            Downloading Packages:
            tcpdump-4.99.0-9.el9.x86_64.rpm             1.8 MB/s | 542 kB     00:00
            ----------------------------------------------------------------------------
            Total                                       1.1 MB/s | 542 kB     00:00
            Running transaction check
            Transaction check succeeded.
            Running transaction test
            Transaction test succeeded.
            Running transaction
              Preparing        :                                                    1/1
              Running scriptlet: tcpdump-14:4.99.0-9.el9.x86_64                     1/1
              Installing       : tcpdump-14:4.99.0-9.el9.x86_64                     1/1
              Running scriptlet: tcpdump-14:4.99.0-9.el9.x86_64                     1/1
              Verifying        : tcpdump-14:4.99.0-9.el9.x86_64                     1/1
            
            Installed:
              tcpdump-14:4.99.0-9.el9.x86_64
            
            Complete!
            [root@kvm1 ~]#

effectuez deux captures, pendant que les VMs sont en train de se ping :

* une qui capture le trafic de l'interface réelle : eth1 probablement (celle qui a l'IP host-only, celle qui porte 10.3.1.12 sur kvm2 par exemple)

            [root@kvm1 ~]# sudo tcpdump -i ens192 udp port 8472 -w vxlan-raw.pcap
            dropped privs to tcpdump
            tcpdump: listening on ens192, link-type EN10MB (Ethernet), snapshot length 262144 bytes
            
          
            ^C110 packets captured
            110 packets received by filter
            0 packets dropped by kernel

* une autre qui capture le trafic de l'interface bridge VXLAN/ on l'a appelée vxlan-bridge dans le TP

              [root@kvm1 ~]# sudo tcpdump -i vxlan_bridge -w vxlan-vm.pcap
            dropped privs to tcpdump
            tcpdump: listening on vxlan_bridge, link-type EN10MB (Ethernet), snapshot length 262144 bytes
            ^C52 packets captured
            52 packets received by filter
            0 packets dropped by kernel

petit rappel d'une commande tcpdump :


➜ Analysez les deux captures

dans la capture de eth1 vous devriez juste voir du trafic UDP entre les deux noeuds

            [root@kvm1 ~]# tshark -r vxlan-raw.pcap -Y "udp.port == 8472"
            Running as user "root" and group "root". This could be dangerous.
                1   0.000000    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
                2   0.003259    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
                3   1.004043    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
                4   1.005124    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
                5   2.003156    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
                6   2.005045    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
                7   3.002453    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
                8   3.003480    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
                9   4.001382    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               10   4.001899    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               11   4.974025    10.3.1.12 → 10.3.1.11    UDP 92 42726 → 8472 Len=50
               12   4.975034    10.3.1.11 → 10.3.1.12    UDP 92 34960 → 8472 Len=50
               13   5.005536    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               14   5.006384    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               15   5.379664    10.3.1.11 → 10.3.1.12    UDP 92 34960 → 8472 Len=50
               16   5.381020    10.3.1.12 → 10.3.1.11    UDP 92 42726 → 8472 Len=50
               17   6.017481    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               18   6.018993    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               19   7.016467    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               20   7.017745    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               21   8.017287    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               22   8.018469    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               23   9.016955    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               24   9.017537    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               25  10.017163    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               26  10.018075    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               27  11.025575    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               28  11.026271    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               29  12.034514    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               30  12.035428    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               31  13.033570    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               32  13.034183    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               33  14.032571    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               34  14.033446    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               35  15.031816    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               36  15.033114    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               37  16.030783    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               38  16.032630    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               39  17.033955    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               40  17.035443    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               41  18.041725    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               42  18.042060    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               43  19.042024    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               44  19.042565    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               45  20.040747    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               46  20.041438    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               47  21.050463    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               48  21.051355    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               49  22.049625    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               50  22.050834    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               51  23.048757    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               52  23.049156    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               53  24.059235    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               54  24.059738    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               55  25.057925    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               56  25.059152    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               57  26.064799    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               58  26.065833    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               59  27.063903    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               60  27.064808    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               61  28.073812    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               62  28.075881    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               63  29.071619    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               64  29.072261    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               65  30.070501    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               66  30.071759    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               67  30.964324    10.3.1.12 → 10.3.1.11    UDP 92 42726 → 8472 Len=50
               68  30.964958    10.3.1.11 → 10.3.1.12    UDP 92 34960 → 8472 Len=50
               69  31.080402    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               70  31.081006    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               71  32.079997    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               72  32.080561    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               73  33.083201    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               74  33.083829    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               75  34.081789    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               76  34.083222    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               77  35.087886    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               78  35.088904    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               79  36.087415    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               80  36.088025    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               81  36.102332    10.3.1.11 → 10.3.1.12    UDP 92 34960 → 8472 Len=50
               82  36.102831    10.3.1.12 → 10.3.1.11    UDP 92 42726 → 8472 Len=50
               83  37.096893    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               84  37.097493    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               85  38.095919    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               86  38.097105    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               87  39.094910    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               88  39.096076    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               89  40.100118    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               90  40.101055    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               91  41.099382    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               92  41.100569    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               93  42.100272    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               94  42.101273    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               95  43.107120    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               96  43.107495    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               97  44.105577    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
               98  44.106562    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
               99  45.105201    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
              100  45.106450    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
              101  46.111375    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
              102  46.112163    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
              103  47.109431    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
              104  47.110078    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
              105  48.108922    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
              106  48.109685    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
              107  49.107893    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
              108  49.108848    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
              109  50.106556    10.3.1.12 → 10.3.1.11    UDP 148 56848 → 8472 Len=106
              110  50.107599    10.3.1.11 → 10.3.1.12    UDP 148 51318 → 8472 Len=106
            [root@kvm1 ~]#
si vous regardez bien, vous devriez que ce trafic UDP contient lui-même des trames
dans la capture de vxlan-bridge, vous devriez voir les "vraies" trames échangées par les deux VMs

                   [root@kvm1 ~]# tshark -r vxlan-vm.pcap
                  Running as user "root" and group "root". This could be dangerous.
                      1   0.000000 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=1/256, ttl=64
                      2   0.000909 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=1/256, ttl=64 (request in 1)
                      3   0.001076 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=1/256, ttl=64
                      4   0.999552 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=2/512, ttl=64
                      5   0.999994 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=2/512, ttl=64 (request in 4)
                      6   1.000063 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=2/512, ttl=64
                      7   1.997917 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=3/768, ttl=64
                      8   1.998450 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=3/768, ttl=64 (request in 7)
                      9   1.998667 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=3/768, ttl=64
                     10   3.002300 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=4/1024, ttl=64
                     11   3.003336 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=4/1024, ttl=64 (request in 10)
                     12   3.003856 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=4/1024, ttl=64
                     13   3.055475 10.220.220.201 → 10.220.220.4 SSH 118 Client: Encrypted packet (len=52)
                     14   3.057257 10.220.220.4 → 10.220.220.201 SSH 102 Server: Encrypted packet (len=36)
                     15   3.057293 10.220.220.201 → 10.220.220.4 TCP 66 55818 → 22 [ACK] Seq=53 Ack=37 Win=548 Len=0 TSval=812527829 TSecr=3269628585
                     16   4.001283 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=5/1280, ttl=64
                     17   4.002207 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=5/1280, ttl=64 (request in 16)
                     18   4.002370 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=5/1280, ttl=64
                     19   4.946194 5e:c8:73:05:a4:8a → 02:00:0a:dc:dc:04 ARP 42 Who has 10.220.220.4? Tell 10.220.220.202
                     20   4.948087 02:00:0a:dc:dc:04 → 5e:c8:73:05:a4:8a ARP 42 10.220.220.4 is at 02:00:0a:dc:dc:04
                     21   5.000021 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=6/1536, ttl=64
                     22   5.000915 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=6/1536, ttl=64 (request in 21)
                     23   5.001081 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=6/1536, ttl=64
                     24   5.440827 0a:b4:a5:4f:26:06 → 5e:c8:73:05:a4:8a ARP 42 Who has 10.220.220.202? Tell 10.220.220.201
                     25   5.442845 5e:c8:73:05:a4:8a → 0a:b4:a5:4f:26:06 ARP 42 10.220.220.202 is at 5e:c8:73:05:a4:8a
                     26   6.000983 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=7/1792, ttl=64
                     27   6.002195 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=7/1792, ttl=64 (request in 26)
                     28   6.999905 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=8/2048, ttl=64
                     29   7.000585 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=8/2048, ttl=64 (request in 28)
                     30   8.007846 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=9/2304, ttl=64
                     31   8.008988 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=9/2304, ttl=64 (request in 30)
                     32   9.006515 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=10/2560, ttl=64
                     33   9.007054 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=10/2560, ttl=64 (request in 32)
                     34  10.018122 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=11/2816, ttl=64
                     35  10.018758 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=11/2816, ttl=64 (request in 34)
                     36  11.022504 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=12/3072, ttl=64
                     37  11.023144 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=12/3072, ttl=64 (request in 36)
                     38  12.023776 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=13/3328, ttl=64
                     39  12.024757 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=13/3328, ttl=64 (request in 38)
                     40  12.303496 10.220.220.201 → 10.220.220.4 SSH 118 Client: Encrypted packet (len=52)
                     41  12.304494 10.220.220.4 → 10.220.220.201 SSH 102 Server: Encrypted packet (len=36)
                     42  12.304511 10.220.220.201 → 10.220.220.4 TCP 66 55818 → 22 [ACK] Seq=105 Ack=73 Win=548 Len=0 TSval=812537077 TSecr=3269637833
                     43  13.021199 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=14/3584, ttl=64
                     44  13.022082 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=14/3584, ttl=64 (request in 43)
                     45  14.028359 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=15/3840, ttl=64
                     46  14.028914 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=15/3840, ttl=64 (request in 45)
                     47  15.025486 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=16/4096, ttl=64
                     48  15.026455 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=16/4096, ttl=64 (request in 47)
                     49  16.026833 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=17/4352, ttl=64
                     50  16.027376 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=17/4352, ttl=64 (request in 49)
                     51  17.030466 10.220.220.202 → 10.220.220.4 ICMP 98 Echo (ping) request  id=0x000a, seq=18/4608, ttl=64
                     52  17.031441 10.220.220.4 → 10.220.220.202 ICMP 98 Echo (ping) reply    id=0x000a, seq=18/4608, ttl=64 (request in 51)
                  [root@kvm1 ~]#

