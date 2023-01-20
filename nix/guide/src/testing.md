# Testing

To test the `teloshost` ansible role, we will use the `lxd` virtual machine manager and launch an Ubuntu machine.

Navigate to test directory, which contains all the materials for testing our role:

```sh
cd test
```

Copy and edit cloud-init configuration and Ansible inventory:

```sh
cp cloud-config.tmpl.yaml cloud-config.test.yaml
cp inventory.tmpl.yaml inventory.test.yaml
```

Launch an lxc with the custom cloud-init user data:

```sh
lxc launch ubuntu:jammy teloshost --config=user.user-data="$(cat ./cloud-config.test.yaml)"
lxc exec teloshost -- cloud-init status --wait
```

Install Ansible requirements:

```sh
ansible-galaxy install -r requirements.yaml
```

Create an SSH host entry for `teloshost`. Create an inventory file from the
provided template, and then, run Ansible playbook:

```sh
ansible-playbook -i inventory.test.yaml playbook.yaml
```