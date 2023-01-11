# Welcome to teloshost devshell

This repository contains [cloud-init][cloud-init] configuration template and
[Ansible][ansible] playbook to setup and configure a `teloshost`.

Very briefly:

1. Cloud-init is used only once when we provision a new server on the cloud
   service provider.
2. Ansible playbook is immediately after the server is provisioned and onwards
   on an ongoing basis.

In a nutshell:

1. Cloud-init template ensures that:
   1. Timezone, hostname and fqdn are set.
   2. Package updates and upgrades are performed before we run Ansible playbooks.
   3. We have a default user, namely `patron`.
   4. Initial SSH authorized keys are added to `patron` user.
2. Ansible playbook ensures that:
   1. Base system is configured.
   2. System packages are installed.
   3. Requested service installations and configurations are performed.
   4. Monitoring is setup.
