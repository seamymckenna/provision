# Provision

Provision hosts for discovery

## Prerequisites

- Ruby installed >= 2.3.1
- Beaker installed (`gem install beaker`)
- Vmpooler RSA private key stored in ~/.ssh/id_rsa-acceptance

## To Use

```sh
gem install bundler  # first time
rake provision
```

## Output

Default operation will provide
- 4 vms,
- 1 windows,
- 1 centos, (with web server)
- 1 rhel,
- 1 Ubuntu (with docker engine, and 5 containers)

On completion, this will output a JSON file containing Ips and metrics which can be verified in the UI, e.g.

```json
{
  "ips": [
    "vikm5kvjp5ehre9.delivery.puppetlabs.net",
    "h1rjl7c98fyw1zc.delivery.puppetlabs.net",
    "j3czintnljm4s0u.delivery.puppetlabs.net",
    "ufv92zk3cnta82k.delivery.puppetlabs.net"
  ],
  "total_packages": "WIP",
  "total_containers": 5,
  "total_servers": 4,
  "total_windows": 1,
  "total_linux": 3,
  "docker_hosts": 1,
  "web_servers": 1,
  "sql_servers": 0
}
```

## Options

To change the number/type of vms pass in a beaker hostgenerator arg.
E.g rake provision hosts=windows2016-64-redhat7-64
For a full list of host strings, run;
`beaker-hostgenerator -l`

Note that all ubuntu vms will be configured as docker engines and all centos boxes will be webserver.

## VM Lifetime

The VM's default lifetime will be 2 unless you have a token defined in your ~/.fog file, where default time becomes 12 hours.

See [vmpooler info](https://confluence.puppetlabs.com/pages/viewpage.action?pageId=28610683#Using"vmpooler"forManualTesting-The"vmfloaty"Utility) for further details.
