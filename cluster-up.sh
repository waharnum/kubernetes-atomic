#!/bin/bash
echo "Clearing the vagrant box IPs from known hosts"
ssh-keygen -R 192.168.87.10 && ssh-keygen -R 192.168.87.11
vagrant up
echo "Temporarily disabling Ansible host key checking for this terminal via env variable"
export ANSIBLE_HOST_KEY_CHECKING=False
ansible-playbook playbook-master.yml -i inventory
ansible-playbook playbook-nodes.yml -i inventory
ansible-playbook playbook-dns.yml -i inventory
echo "Reenabling Ansible hot key checking"
export ANSIBLE_HOST_KEY_CHECKING=True
