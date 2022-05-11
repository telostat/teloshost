#!/usr/bin/env python3

import argparse

import jinja2

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="Generate cloud-init configuration.")
    parser.add_argument("--hostname", required=True, help="Hostname")
    parser.add_argument("--fqdn", required=True, help="FQDN")
    parser.add_argument("--personnel", nargs="+", help="Personnel")
    parser.add_argument("--monitor-url", required=True, help="Demonitor URL")
    parser.add_argument("--monitor-token", required=True, help="Demonitor Token")
    parser.add_argument(
        "--monitor-organization", required=True, help="Demonitor Organization"
    )
    parser.add_argument("--monitor-bucket", required=True, help="Demonitor Bucket")

    args = parser.parse_args()

    with open("cloud-config.yml.j2") as cfile:
        template = jinja2.Template(cfile.read())

    print(template.render(vars(args)))
