# Cloud Host Configuration

## Usage

Enter into the `nix-shell`:

```sh
nix-shell
```

See the usage of cloud-init configuration generator:

```console
$ ./generate.py --help
usage: generate.py [-h] --hostname HOSTNAME --fqdn FQDN [--personnel PERSONNEL [PERSONNEL ...]] --monitor-url MONITOR_URL --monitor-token MONITOR_TOKEN --monitor-organization MONITOR_ORGANIZATION --monitor-bucket MONITOR_BUCKET

Generate cloud-init configuration.

optional arguments:
  -h, --help            show this help message and exit
  --hostname HOSTNAME   Hostname
  --fqdn FQDN           FQDN
  --personnel PERSONNEL [PERSONNEL ...]
                        Personnel
  --monitor-url MONITOR_URL
                        Demonitor URL
  --monitor-token MONITOR_TOKEN
                        Demonitor Token
  --monitor-organization MONITOR_ORGANIZATION
                        Demonitor Organization
  --monitor-bucket MONITOR_BUCKET
                        Demonitor Bucket
```

Generate a configuration file (dummy example):

```sh
./generate.py \
    --hostname             teloshost                   \
    --fqdn                 teloshost.example.com       \
    --personnel            gh:fkoksal gh:vst           \
    --monitor-url          https://monitor.example.com \
    --monitor-token        MONITOR-TOKEN               \
    --monitor-organization MONITOR_ORGANIZATION        \
    --monitor-bucket       MONITOR_BUCKET              \
  > cloud-config.yml
```

## Testing

Launch an lxc with the custom cloud-init user data:

```sh
lxc launch ubuntu:jammy teloshost --config=user.user-data="$(cat ./cloud-config.yml)"
```

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
