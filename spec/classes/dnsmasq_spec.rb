require 'spec_helper'

describe 'dnsmasq' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'no parameters' do
        it { is_expected.to compile }
      end

      describe 'parameter: nameserver' do
        context 'valid ip, string' do
          let(:params) do
            {
              nameserver: '10.10.10.10'
            }
          end

          it {
            is_expected.to contain_file('/etc/dnsmasq.resolv').with(
              'content' => /^nameserver 10.10.10.10$/,
            )
          }
        end

        context 'valid ip, array' do
          let(:params) do
            {
              nameserver: [
                '20.20.20.20',
                '30.30.30.30'
              ]
            }
          end

          it {
            is_expected.to contain_file('/etc/dnsmasq.resolv').with(
              'content' => /^nameserver 20.20.20.20$/,
            )
          }

          it {
            is_expected.to contain_file('/etc/dnsmasq.resolv').with(
              'content' => /^nameserver 30.30.30.30$/,
            )
          }
        end

        context 'invalid ip' do
          let(:params) do
            {
              nameserver: [
                '20.20.256.256',
                '30.30.30.30'
              ]
            }
          end

          it { is_expected.not_to compile }
        end
      end

      describe 'parameter: hosts' do
        context 'valid input' do
          let(:params) do
            {
              hosts: [
                '10.10.10.10' => ['test1'],
                '20.20.20.20' => ['test2', 'test3'],
                '30.30.30.30' => ['test4', 'test5', 'test6'],
              ]
            }
          end

          it {
            is_expected.to contain_file('/etc/dnsmasq.hosts').with(
              'content' => /^10.10.10.10 test1$/,
            )
          }

          it {
            is_expected.to contain_file('/etc/dnsmasq.hosts').with(
              'content' => /^20.20.20.20 test2$/,
            )
          }

          it {
            is_expected.to contain_file('/etc/dnsmasq.hosts').with(
              'content' => /^20.20.20.20 test3$/,
            )
          }

          it {
            is_expected.to contain_file('/etc/dnsmasq.hosts').with(
              'content' => /^30.30.30.30 test4$/,
            )
          }

          it {
            is_expected.to contain_file('/etc/dnsmasq.hosts').with(
              'content' => /^30.30.30.30 test5$/,
            )
          }

          it {
            is_expected.to contain_file('/etc/dnsmasq.hosts').with(
              'content' => /^30.30.30.30 test6$/,
            )
          }
        end
      end

      describe 'parameter: service_enable' do
        let(:params) do
          {
            service_enable: false,
          }
        end

        it {
          is_expected.to contain_service('dnsmasq').with(
            'enable' => false,
          )
        }
      end

      describe 'parameter: service_hasstatus' do
        let(:params) do
          {
            service_hasstatus: false,
          }
        end

        it {
          is_expected.to contain_service('dnsmasq').with(
            'hasstatus' => false,
          )
        }
      end

      describe 'parameter: service_ensure' do
        let(:params) do
          {
            service_ensure: 'stopped',
          }
        end

        it {
          is_expected.to contain_service('dnsmasq').with(
            'ensure' => 'stopped',
          )
        }
      end

      describe 'parameter: package_ensure' do
        let(:params) do
          {
            package_ensure: 'latest',
          }
        end

        it {
          is_expected.to contain_package('dnsmasq').with(
            'ensure' => 'latest',
          )
        }
      end

      describe 'parameter: package_name' do
        let(:params) do
          {
            package_name: 'dns_masq',
          }
        end

        it {
          is_expected.to contain_package('dns_masq').with(
            'name' => 'dns_masq',
          )
        }
      end

      describe 'parameter: service_name' do
        let(:params) do
          {
            service_name: 'dns_masq',
          }
        end

        it {
          is_expected.to contain_service('dns_masq').with(
            'name' => 'dns_masq',
          )
        }
      end

    end
  end
end
