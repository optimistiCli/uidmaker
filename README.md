# System Internal User Maker for Synology DSM

## DSM 7
DSM 7 is **not** supported, but there is a workaround that *almost* works on DSM 7. Try installing via CLI – the installation will fail but user and group get added. Here's the how you can use it:
```bash
# Creating group named 'foobar'
./uidmaker.sh foobar
# This should have cooked DSM package uidmaker_foobar.spk
# Try installing it now
sudo synopkg install uidmaker_foobar.spk
# Installation fails but user and group both named 'foobar' do get created
# Add real-life user 'bizwiz' to 'foobar' group
sudo synogroup --memberadd foobar bizwiz
# Exit this shell session and login anew for the changes to take effect
```

## Usage
```bash
uidmaker.sh <username> [<groupname>]
```

## The Purpose of This Script
When building a package for Synology DSM a developer has an option to specify a user and a group name this package will run as. The user accounts ceated by those packages fall into a special category dubbed “System Internal Users” or “Package Users”. They do not mingle withe the “normal” users in the DSM GUI and they are by default restricted from most services.

I think it would be reasonable to use this System Internal Users for running services with Docker on DSM. Unfortunately there seems to be no simple way of creating those accounts. As a workaround I wrote this script that uses the minimal package from Synology DSM Developer Guide as a base to generate dummy packages. Each of these packages, when installed, creates system internal user and group.

## Features and Limitations
* You can run this script on DSM or on any reasonable system that has bash 3.2 or above and core utilities.
* This script generates packages compatible only with x86_64 systems.
* Home directory and default shell are set by DSM to some defaults and tipically need to be edited directly in /etc/passwd.
* If no group name is provided then a group with the same name as the user is created.
* The UID is in the 100000 ~ 300000 range and the GID is the same as UID.

## How to Use This Script
To make a package that would create user called foobar run:
```bash
$ uidmaker.sh foobar
```
The the package .spk file will be created in the current directory:
```bash
$ ls *.spk
uidmaker_foobar.spk
```
Now the package can be installed on DSM via GUI: 
* Select Package Center → Manual Install
* Pick the newly genegated .spk file
* Click through the menus

Once the installation is complete the package can (and should) be uninstalled.

You can also check /etc/passwd and /etc/group for the new user:
```bash
$ grep foobar /etc/passwd
foobar:x:123456:123456::/var/packages/uidmaker_foobar/target:/sbin/nologin
$ grep foobar /etc/group
foobar:x:123456:
```

## Usefull Links
* For username limitations on DSM please check the [article on creating users](https://www.synology.com/en-global/knowledgebase/DSM/help/DSM/AdminCenter/file_user_create) in Synology knowlage base.
* Building DSM packsges is covered in [Synology DSM Developer Guide](https://originhelp.synology.com/developer-guide/index.html).
* [CLI Administrator Guide for Synology NAS](https://global.download.synology.com/download/Document/Software/DeveloperGuide/Firmware/DSM/All/enu/Synology_DiskStation_Administration_CLI_Guide.pdf)

## Disclaimer

You can use this script in any manner that suits you though remember at all times that by using it you agree that you use it at your own risk and neither I nor anybody else except for yourself is to be held responsible in case anything goes wrong as a result of using this script.
