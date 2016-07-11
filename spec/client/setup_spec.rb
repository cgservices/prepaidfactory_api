require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe 'setup' do

    it 'can handle empty certificate path' do
      config = Hash[CONFIG]
      config['pem_cert'] = ''
      expect {
        PrepaidfactoryApi::Client.new(config)
      }.to raise_error(PrepaidfactoryApi::NoCertificate)
    end

    it 'can handle empty certificate key path' do
      config = Hash[CONFIG]
      config['pem_key'] = ''
      expect {
        PrepaidfactoryApi::Client.new(config)
      }.to raise_error(PrepaidfactoryApi::NoCertificateKey)
    end

    it 'can handle invalid certificates correctly' do
      config = Hash[CONFIG]
      config['pem_cert'] = './README.md' # File just needs to exists
      config['pem_key'] = './README.md' # File just needs to exists
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::CertificateError)
    end

    it 'can verify all certificates' do
      config = Hash[CONFIG]
      #config['ssl_verify_mode'] =
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::SSLError)
    end

    it 'can handle wrong credentials' do
      config = Hash[CONFIG]
      config['username'] = ''
      config['password'] = ''
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::AuthenticationError)
    end

    it 'can handle an unreachable endpoint' do
      config = Hash[CONFIG]
      config['endpoint'] = ''
      expect {
        client = PrepaidfactoryApi::Client.new(config)
        client.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new(config['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::False)
    end

  end

end
