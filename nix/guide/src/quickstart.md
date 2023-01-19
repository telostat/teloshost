# Welcome to Teloshost Developer’s Guide

This repository contains [Ansible](https://www.ansible.com/) role to setup and configure a `teloshost`.

A `teloshost` is an Ubuntu server that we provision in an opinionated way. The
objective is to streamline management of servers provisioned regardless of their
ultimate purpose.

Include this into your playbook to start using the `teloshost` role:

```sh
- name: Setup a teloshost
  hosts: all
  become: true
  roles:
    - name: teloshost
```

Have a look at our [Testing](./testing.md) section for more detailed explanation on how to test the role on a virtual machine.

You can access this guide at anytime by issuing:

```sh
devsh guide
```

Enjoy...
