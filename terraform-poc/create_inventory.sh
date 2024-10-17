#!/bin/bash

# Get the private IP from Terraform output
vm_private_ip=$(terraform output -raw vm_private_ip)

# Create the Ansible inventory file
cat <<EOL > ansible/inventory.ini
[windows]
$vm_private_ip ansible_user=adminuser ansible_password=Welcome#2024 ansible_connection=winrm ansible_port=5986 ansible_winrm_transport=ntlm ansible_winrm_server_cert_validation=ignore
EOL

echo "Inventory file created at ansible/inventory.ini"