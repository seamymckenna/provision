# Provision
Provision hosts for discovery

## Prerequisites
Ruby installed >= 2.3.1
Vmpooler RSA private key stored in ~/.ssh/id_rsa-acceptance

## To Use
```gem install bundler (first time)
rake provision
```

## Output
Default operation will provides 4 vms,
1 windows,
1 centos, (with web server)
1 rhel,
1 Ubuntu (with docker engine, and 5 containers)

On completion, this will output a JSON file containing Ips and metrics which can be verified in the UI.
E.g
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

## Options
To change the number/type of vms pass in a beaker hostgenerator arg.
E.g rake provision hosts=windows2016-64-redhat7-64
For a full list of host strings, run;
`beaker-hostgenerator -l`

Note that all ubuntu vms will be configured as docker engines and all centos boxes will be webserver.
