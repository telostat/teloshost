# Useful Commands

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