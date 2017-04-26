require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'setup_savon' do
    it 'can handle empty certificate path' do
      config = Hash[CONFIG]
      config['pem_cert'] = ''
      expect {
        PrepaidfactoryApi::Client.new(config)
      }.to raise_error(PrepaidfactoryApi::ConnectionNoCertificate)
    end

    it 'can handle empty certificate key path' do
      config = Hash[CONFIG]
      config['pem_key'] = ''
      expect {
        PrepaidfactoryApi::Client.new(config)
      }.to raise_error(PrepaidfactoryApi::ConnectionNoCertificateKey)
    end

    it 'can handle invalid certificates correctly' do
      config = Hash[CONFIG]
      config['pem_cert'] = './README.md' # File just needs to exists
      config['pem_key'] = './README.md' # File just needs to exists
      expect do
        client = PrepaidfactoryApi::Client.new(config)
        client.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      end.to raise_error(PrepaidfactoryApi::ConnectionCertificateError)
    end

    it 'can verify all certificates' do
      config = Hash[CONFIG]
      config['ssl_verify_mode'] = :peer
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to_not raise_error
    end

    xit 'can handle error on certificate verification' do
      config = Hash[CONFIG]
      config['ssl_ca_cert_file'] = './README.md'
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::ConnectionSSLError)
    end

    xit 'can handle wrong credentials' do
      config = Hash[CONFIG]
      config['username'] = ''
      config['password'] = ''
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::ConnectionAuthenticationError)
    end

    it 'can handle empty endpoint' do
      config = Hash[CONFIG]
      config['endpoint'] = ''
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::ConnectionNoValidEndpointSpecified)
    end

    xit 'can handle an unreachable endpoint' do
      config = Hash[CONFIG]
      config['endpoint'] = 'http://this.is.just.a.bogus.endpoint'
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::ConnectionEndpointUnavailable)
    end
  end
end
