#!/bin/bash

# Create directories for storing authorized_keys files
mkdir -p dns web database

# Copy authorized_keys from each host
scp dns:/home/blueteam/.ssh/authorized_keys dns/authorized_keys
scp web:/home/blueteam/.ssh/authorized_keys web/authorized_keys
scp database:/home/blueteam/.ssh/authorized_keys database/authorized_keys