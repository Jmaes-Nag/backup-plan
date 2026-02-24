#!/bin/bash
# Backup files for database machine
ssh database "sudo -u postgres pg_dumpapp -c" | gzip > /home/blueteam/database/postgres/db_dump$(date +%H-%M-%S).sql.gz
ssh database "sudo -u postgres /usr/bin/cat /etc/postgresql/12/main/pg_hba.conf" > /home/blueteam/database/postgres/configs/pg_hba_$(date +%H-%M-%S).conf
ssh database "sudo -u postgres /usr/bin/cat /etc/postgresql/12/main/postgresql.conf" > /home/blueteam/database/postgres/configs/postgresql_$(date +%H-%M-%S).conf