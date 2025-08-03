#!/bin/bash

component=$1
dnf install ansible -y
ansible-pull -U https://github.com/Sameer-Sarrainodu/Ansible-Roboshop-Roles.git -e component=$1 main.yaml