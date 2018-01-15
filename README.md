[![Build Status](https://travis-ci.org/mediapeers/ansible-role-influxdb.svg?branch=master)](https://travis-ci.org/mediapeers/ansible-role-influxdb)

# Ansible InfluxDB server role

Role that sets up a complete TICK stack server (not installing telegraf). It will install a compleete setup of InfluxDB, Chronograf and Kapacitor.

This role is meant for a server that receives metrics from the Telegraf agent and stores them in InfluxDB and allow monitoring and alerting
through Chronograf and Kapacitor all on one host. Chronograf will be configured with Github OAuth to protect from public access.


## Requirements

Debian or Ubuntu server. Open port 8086 to receive InfluxDB traffic from outside this machine. Also open port 8888 to expose Chronograf to the outside
world or another port if you change the config or put a webserver infront of it.

## Role Variables

Role variables you should change:

- `github_secret` - GH app secret
- ....


## Dependencies

Depends on no other role

## Example Playbook

Example role integration into your play:

    - hosts: servers
      vars:
        influxdb_port: 123
      roles:
         - mediapeers.influxdb
      tasks:
        # other tasks

## License

BSD, as-is.

## Author Information

Stefan Horning <horning@mediapeers.com>
