# General Plan
Because if you fail to plan, you plan to fail.

In an environment, you never know if someone is compromised. Therefore, the backup server will not allow inbound connections, but will instead reach out to other servers and copy from the service server to the backup server.

## Breaking into the machine
Sometimes you forget your credentials, here's how to reset them on linux as long as the boot drive isn't encrypted.

Method: Using Recovery Mode
1. Boot the machine, and hold `Shift`, you'll be brough to the GRUB menu.
2. From the menu, select the 2nd option from the top, as long as it contains `(recovery mode)`.
3. In the recovery menu, scroll down and select `root`.
4. Mount the drive: `mount -o remount,rw /`.
5. Reset the password: `passwd [USERNAME]`.
6. Set the new password
7. Reboot and login.

## Firewall Rules
We only want what we want to come in.

```bash
sudo ufw default deny incoming
sudo ufw default deny outgoing
sudo ufw allow out to any port 22 proto tcp
sudo ufw enable
sudo ufw status verbose
```

## Setup SSH connection from Backup
1. Generate ssh key pairs for the VMs (Web, DNS, DB)
2. Move public keys to the blueteam accepted keys

```bash
# create the key, follow prompts
ssh-keygen

# copy the pubkey to service machine
ssh-copy-id -i ~/.ssh/key.pub blueteam@192.168.[T].[X]

# copy priv to backup
scp ~/.ssh/[name] blueteam@192.168.[T].[X]
```

## Machines

Before backing up... update time: `sudo timedatectl set-timezone America/Boise

### Web

### DNS

### Database

Important files:
- /etc/postgresql/14/main/pg_hba.conf
- /etc/postgresql/14/main/postgres.conf

To setup postgres backup, be sure to add the following line to visudo:
```
blueteam ALL=(postgres) NOPASSWD: /usr/bin/pg_dumpall
blueteam ALL=(postgres) NOPASSWD: /usr/bin/cat /etc/postgresql/12/pg_hba.conf
blueteam ALL=(postgres) NOPASSWD: /usr/bin/cat /etc/postgresql/12/postgresql.conf
```
This file ensures that specifically for the command `pg_dumpall`, a password is not required

Back up the whole database:
```bash
ssh -i ~/.ssh/id_ed25519 -o StrictHostKeyChecking=no root@<POSTGRES_IP> "sudo -u postgres pg_dumpall -c" | gzip > /home/blueteam/database/postgres/db_dump_$(date +%Y-%m-%d_%H-%M-%S).sql.gz
```
