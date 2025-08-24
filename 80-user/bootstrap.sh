#!/bin/bash

component=$1
env=$2
dnf install ansible -y
ansible-pull -U https://github.com/Sameer-Sarrainodu/Ansible-Roles-Terraform.git -e component=$1 -e env=$2 main.yaml