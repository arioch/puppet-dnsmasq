require 'spec_helper'

describe 'dnsmasq::pxe' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      describe 'no parameters' do
        it { is_expected.to compile }
      end

      describe 'parameter: tftp' do
        context 'true' do
          let(:params) do
            {
              tftp: true
            }
          end

          it {
            is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
              'content' => /^enable-tftp$/,
            )
          }
        end

        context 'false' do
          let(:params) do
            {
              tftp: false
            }
          end

          it {
            is_expected.not_to contain_file('/etc/dnsmasq.d/pxe.conf').with(
              'content' => /^enable-tftp$/,
            )
          }
        end
      end

      describe 'parameter: tftp_root' do
        let(:params) do
          {
            tftp_root: '/tftp/root',
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^tftp-root=\/tftp\/root$/,
          )
        }
      end

      describe 'parameter: dhcp_ignore' do
        let(:params) do
          {
            dhcp_ignore: 'tag:#known'
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-ignore=tag:#known$/,
          )
        }
      end

      describe 'parameter: dhcp_range' do
        let(:params) do
          {
            dhcp_range: {
              from:    '20.20.20.20',
              to:      '20.20.20.30',
              timeout: '30m',
            }
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-range=20.20.20.20,20.20.20.30,30m$/,
          )
        }
      end

      describe 'parameter: dhcp_gateway' do
        let(:params) do
          {
            dhcp_gateway: '20.20.20.1',
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-option=3,20.20.20.1 # gateway$/,
          )
        }
      end

      describe 'parameter: dns_server' do
        let(:params) do
          {
            dns_server: '20.20.20.2',
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-option=6,20.20.20.2 # dns$/,
          )
        }
      end

      describe 'parameter: tftp_server' do
        let(:params) do
          {
            tftp_server: '20.20.20.3',
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-option=66,20.20.20.3 # tftp$/,
          )
        }
      end

      describe 'parameter: dhcp_boot' do
        let(:params) do
          {
            dhcp_boot: 'image.0',
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-boot=image.0$/,
          )
        }
      end

      describe 'parameter: dhcp_host' do
        let(:params) do
          {
            dhcp_host: [
              '11:11:11:11:11:11' => '10.10.10.10',
              '22:22:22:22:22:22' => '20.20.20.20',
            ],
          }
        end

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-host=11:11:11:11:11:11,10.10.10.10$/,
          )
        }

        it {
          is_expected.to contain_file('/etc/dnsmasq.d/pxe.conf').with(
            'content' => /^dhcp-host=22:22:22:22:22:22,20.20.20.20$/,
          )
        }
      end
    end
  end
end
