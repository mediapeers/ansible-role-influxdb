[![Build Status](https://travis-ci.com/mediapeers/ansible-role-influxdb.svg?branch=master)](https://travis-ci.com/mediapeers/ansible-role-influxdb)

# Ansible InfluxDB server role

Role that sets up a complete TICK stack server (not installing telegraf). It will install a complete setup
of [InfluxDB](https://www.influxdata.com/time-series-platform/influxdb/), [Chronograf](https://www.influxdata.com/time-series-platform/chronograf/) and [Kapacitor](https://www.influxdata.com/time-series-platform/kapacitor/).

This role is meant for a server that receives metrics from the [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/) agent and stores them in InfluxDB to allow monitoring and alerting
through Chronograf and Kapacitor all on one host. Chronograf will be configured with Github OAuth to protect from public access.

If you also want to install Telegraf, there is a seperate role [mediapeers.telegraf](https://github.com/mediapeers/ansible-role-telegraf) that can be used on all machines that you want monitored.

## Requirements

Ubuntu 16.04 or newer as OS. Other distros might also work, but they should have the package `python-influxdb` available in their apt repos.
This pacakge is needed as a depedendency for the Ansible influxdb modules to work.

If you use Ansible version below 2.6 you might also have to add influxdb modules to your Ansible project library dir (usually `./libary/`).
Find them at https://github.com/ansible/ansible/tree/devel/lib/ansible/modules/database/influxdb

Also open port 8888 to expose Chronograf to the outside world or another port if you change the config or put a webserver (reverse proxy) infront of it.

## Role Variables

Role variables you should change:

- `chronograf_public_url: https://some-url.com` - Publicly reachable URL of chronograf setup.
- `influxdb_admin_pw: secret_pw` - set your own PW for InfluxDB admin user
- `influxdb_chronograf_pw: secret_pw` - set your own PW for InfluxDB chronograf user (for reading data)
- `influxdb_telegraf_pw: secret_pw` - set your own PW for InfluxDB telegraf user (for ingesting data)
- `influxdb_chronograf_oauth_secret: abc123def` - Random string used as encryption salt.
- `influxdb_chronograf_oauth_github_id: abc123` - OAuth app id provided by Github after creating one.
- `influxdb_chronograf_oauth_github_secret: abc123` -  OAauth app secret provided by Github
- `influxdb_chronograf_oauth_github_org: myorg` - Restrict this to your Github org, make sure your OAuth app is owned by this org.

Optionally you can change more params, see `defaults/main.yml` for details.

Some useful variables to restore state from existing DB backups:

- `influxdb_meta_backup: /some/path/to/influxdb_backup/meta.00` - Path to local InfluxDB meta DB backup file, which will be copied to InfluxDB instance and restored. Will replace all other DB setup (users, tables etc.)
- `influxdb_chronograf_db_backup: /some/path/chronograf-v1.db` - Path to local Chronograf settings DB file. Usually contains settings such as Influx sources and Chronograf auth users
- `influxdb_kapacitor_db_backup: /some/path/kapacitor.db` - Path to local Kapacitor settings DB file. Usually contains alertings settings/TICK scripts etc.

## Dependencies

Depends on no other role

## Example Playbook

Example role integration into your play:

    - hosts: servers
      become: true
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
