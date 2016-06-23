require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe '#setup' do
    it 'can connect' do
      client = PrepaidfactoryApi::Client.new(CONFIG)

      #expect {
        request = PrepaidfactoryApi::Request::GetProductInformation.new(CONFIG['ppf']['retailerId'])
        client.getProductInformation(request)
      #}.to raise_error(PrepaidfactoryApi::Exception, /RetailerID/)
    end

    it 'has valid certificate' do
      client = PrepaidfactoryApi::Client.new
      expect {
        client.getProductInformation
      }.to not_raise_error(PrepaidfactoryApi::Exception, /SSL/)
    end

  end

end
