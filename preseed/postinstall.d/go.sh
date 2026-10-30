#!/bin/bash
set -e

# Install from iso after login

sudo apt -y install ansible git

git clone https://github.com/fredowski/vcae.git
cd ./vcae/ansible
ansible-playbook init-from-shell.yaml
ansible-playbook digitaltechnik.yaml
