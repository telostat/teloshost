# teloshost

This repository contains [cloud-init][cloud-init] configuration template and
[Ansible][ansible] playbook to setup and configure a `teloshost`.

A `teloshost` is an Ubuntu server that we provision in an opinionated way. The
objective is to streamline management of servers provisioned regardless of their
ultimate purpose.

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

## Usage

Very briefly:

1. Cloud-init is used only once when we provision a new server on the cloud
   service provider.
2. Ansible playbook is immediately after the server is provisioned and onwards
   on an ongoing basis.

### Cloud-init Usage

Just copy `./cloud-config.tmpl.yaml` file and edit it. Once you are done, copy
and paste the contents of the file to the management console of your cloud
service provider when you are prompted.

Below table provides the required parameters:

| Key             | Type     | Example                              |
| --------------- | -------- | ------------------------------------ |
| `hostname`      | `string` | `teloshost`                          |
| `fqdn`          | `string` | `teloshost.dev.mac.sys.telostat.com` |
| `ssh_import_id` | `array`  | `["gh:fkoksal", "gh:vst"]`           |

You may wish to perform further configuration if you are familiar with cloud-init.

### Ansible Playbook Usage

Firstly, enter the Nix shell:

```sh
nix-shell
```

Install Ansible requirements:

```sh
ansible-galaxy install -r requirements.yaml
```

Copy `./inventory.tmpl.yaml` file (e.g. `./inventory.yaml`) and edit it. Once
you are done, run the playbook:

```sh
ansible-playbook -i inventory.yaml playbook.yaml
```

For details, refer to [README.Ansible.md](./README.Ansible.md).

## Testing

First, copy and edit cloud-init configuration and Ansible inventory:

```sh
cp cloud-config.tmpl.yaml cloud-config.test.yaml
cp inventory.tmpl.yaml inventory.test.yaml
```

Launch an lxc with the custom cloud-init user data:

```sh
lxc launch ubuntu:jammy teloshost --config=user.user-data="$(cat ./cloud-config.test.yaml)"
lxc exec teloshost -- cloud-init status --wait
```

Create an SSH host entry for `teloshost`. Create an inventory file from the
provided template, and then, run Ansible playbook:

```sh
ansible-playbook -i inventory.test.yaml playbook.yaml
```

### Useful commands

List current lxc instances and locate the test container:

```sh
lxc list
```

Enter the shell:

```sh
lxc shell teloshost
```

Wait until cloud-init to complete successfully:

```sh
cloud-init status --wait
```

Verify that cloud-init has received expected user data:

```sh
cloud-init query userdata
```

Assert that provided user data is a valid cloud-config:

```sh
cloud-init schema --system --annotate
```

Finally, verify that provided user data was applied successfully.

You can tear down the container now:

```sh
lxc stop teloshost
lxc rm teloshost
```

[cloud-init]: https://cloudinit.readthedocs.io
[ansible]: https://docs.ansible.com
