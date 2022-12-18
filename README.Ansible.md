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
