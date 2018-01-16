require 'spec_helper'


describe 'InfluxDB setup' do
  describe package('influxdb') do
    it { should be_installed }
  end

  describe file('/etc/influxdb/influxdb.conf') do
    it { should be_file }
    its(:content) { should include("auth-enabled = true") }
  end

  describe service('influxdb') do
    it { should be_enabled }
  end
end

describe 'Chronograf setup' do
  describe package('chronograf') do
    it { should be_installed }
  end

  describe file('/etc/default/chronograf') do
    it { should be_file }
    its(:content) { should include("CHRONOGRAF_OPTS=\"--public-url #{ANSIBLE_VARS.fetch('chronograf_public_url', 'FAIL')}") }
    its(:content) { should include("--token-secret #{ANSIBLE_VARS.fetch('influxdb_chronograf_oauth_secret', 'FAIL')}") }
    its(:content) { should include("--github-client-id #{ANSIBLE_VARS.fetch('influxdb_chronograf_oauth_github_id', 'FAIL')}") }
    its(:content) { should include("--github-client-secret #{ANSIBLE_VARS.fetch('influxdb_chronograf_oauth_github_secret', 'FAIL')}") }
    its(:content) { should include("--github-organization #{ANSIBLE_VARS.fetch('influxdb_chronograf_oauth_github_org', 'FAIL')}") }
  end

  describe service('chronograf') do
    it { should be_enabled }
  end
end

describe 'Kapacitor setup' do
  describe package('kapacitor') do
    it { should be_installed }
  end

  describe file('/etc/kapacitor/kapacitor.conf') do
    it { should be_file }
    its(:content) { should include("enabled = true") }
    its(:content) { should include("urls = [\"http://#{ANSIBLE_VARS.fetch('influxdb_host', 'FAIL')}:#{ANSIBLE_VARS.fetch('influxdb_port', 'FAIL')}\"]") }
    its(:content) { should include("username = #{ANSIBLE_VARS.fetch('influxdb_admin_user', 'FAIL')}") }
    its(:content) { should include("password = #{ANSIBLE_VARS.fetch('influxdb_admin_pw', 'FAIL')}") }
  end

  describe service('kapacitor') do
    it { should be_enabled }
  end
end
