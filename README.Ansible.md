# Ansible Playbook Documentation

> **TODO:** Provide detailed documentation about the `teloshost` Ansible
> playbook usage and internals.

## Variable Definitions

Variables can be set in one of these locations (from least to highest
presendence) among many others:

1. inventory configuration (for all hosts): `all.vars.teloshost__{*}`
2. inventory configuration (for specific hosts): `all.hosts.<hostname>.teloshost__{*}`
3. variables file: `teloshost__{*}`

To avoid inventory host specific timezone to be overridden by variables file, it
is not advised to set this variable in anywhere else then the inventory
configuration.

For further information about the variable presendence, see:

<https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#variable-precedence-where-should-i-put-a-variable>

## Configuration Variables

| Group      | Variables                                       | Provision | Type            | Default              | Notes                                              |
| ---------- | ----------------------------------------------- | --------- | --------------- | -------------------- | -------------------------------------------------- |
| global     | `inventory_hostname`                            | static    | string          | provided by Ansible  |                                                    |
| global     | `ansible_user_id`                               | static    | string          | provided by Ansible  | Username used to establish the SSH connection with |
| global     | `teloshost__logfile`                            | static    | path            | provided by playbook | Set to `/var/log/teloshost.yaml`                   |
| base       | `teloshost__base__timezone`                     | variable  | string          | `UTC`                |                                                    |
| base       | `teloshost__base__ssh__authorized_keys__common` | variable  | list of strings | `[]`                 | A list of GitHub logins                            |
| base       | `teloshost__base__ssh__authorized_keys__extras` | variable  | list of strings | `[]`                 | A list of GitHub logins                            |
| base       | `teloshost__base__packages__common`             | static    | list of strings | provided by Ansible  | Default system packages to be installed.           |
| base       | `teloshost__base__packages__extras`             | variable  | list of strings | `[]`                 | List of extra system packages to be installed.     |
| caddy      | `teloshost__caddy__enable`                      | variable  | boolean         | `false`              | Indication to enable Caddy service or not          |
| docker     | `teloshost__docker__enable`                     | variable  | boolean         | `false`              | Indication to enable Docker service or not         |
| docker     | `teloshost__docker__ctop_version`               | variable  | string          | `0.7.7`              | Version of `ctop` to be installed                  |
| monitoring | `teloshost__monitoring__enable`                 | variable  | boolean         | `true`               |                                                    |
| monitoring | `teloshost__monitoring__telegraf__url`          | variable  | string          |                      |                                                    |
| monitoring | `teloshost__monitoring__telegraf__token`        | variable  | string          |                      |                                                    |
| monitoring | `teloshost__monitoring__telegraf__bucket`       | variable  | string          |                      |                                                    |
| monitoring | `teloshost__monitoring__telegraf__organization` | variable  | string          |                      |                                                    |
