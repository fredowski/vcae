#!/bin/bash

# Install from iso after login

sudo apt -y install ansible git

git clone https://github.com/fredowski/vcae.git
cd ./vcae/ansible
ansible-playbook desktop.yaml
