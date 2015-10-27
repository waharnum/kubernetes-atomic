# What's This?

A Ansible-based handroll of setting up Kubernetes on CentOS Atomic as described at http://www.projectatomic.io/docs/gettingstarted/

Currently sets up a single master and four nodes, with communication done over a private network

It also does the following:
- sets up the Kubernetes DNS service
- creates an additional CentOS7 server to use as shared storage for the nodes via NFS

Not production-ready but helpful in getting an Atomic-based local cluster up quickly for experimentation.
