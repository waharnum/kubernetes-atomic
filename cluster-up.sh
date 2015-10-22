#!/bin/bash
echo "Clearing the vagrant box IPs from known hosts"
ssh-keygen -R 192.168.87.10 && ssh-keygen -R 192.168.87.11
vagrant up
echo "Temporarily disabling Ansible host key checking for this terminal via env variable"
export ANSIBLE_HOST_KEY_CHECKING=False
echo "configuring master"
ansible-playbook playbook-master.yml -i inventory
echo "configuring nodes"
ansible-playbook playbook-nodes.yml -i inventory
echo "configuring DNS service"
ansible-playbook playbook-dns.yml -i inventory
echo "launching a busybox pod for testing purposes"
ansible-playbook playbook-busybox.yml -i inventory
echo "Reenabling Ansible host key checking"
export ANSIBLE_HOST_KEY_CHECKING=True
