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
  # TODO

  describe service('chronograf') do
    it { should be_enabled }
  end
end

describe 'Kapacitor setup' do
  # TODO

  describe service('kapacitor') do
    it { should be_enabled }
  end
end
