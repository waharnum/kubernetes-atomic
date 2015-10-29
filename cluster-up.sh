#!/bin/bash
echo "Clearing the vagrant box IPs from known hosts"
ssh-keygen -R 192.168.87.10 && ssh-keygen -R 192.168.87.11 && ssh-keygen -R 192.168.87.12 && ssh-keygen -R 192.168.87.13 && ssh-keygen -R 192.168.87.14 && ssh-keygen -R 192.168.87.111
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
echo "configuring nfs server"
ansible-playbook playbook-nfs-server.yml -i inventory
echo "configuring nodes to use nfs server"
ansible-playbook playbook-nfs-node-clients.yml -i inventory
echo "loading samples"
ansible-playbook playbook-samples.yml -i inventory
echo "Reenabling Ansible host key checking"
export ANSIBLE_HOST_KEY_CHECKING=True
