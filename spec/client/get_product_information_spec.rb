require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe 'GetProductInformation' do

    it 'can retrieve products' do
      expect {
        CLIENT.request(:unknown_operation, PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['ppf']['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::UnknownOperation)
    end

    it 'can handle a wrong retailer_id' do
      expect {
        CLIENT.request(:get_product_information, PrepaidfactoryApi::Requests::GetProductInformation.new('PPF-RETAILER-TEST-ID'))
      }.to raise_error(PrepaidfactoryApi::SOAPFault)
    end

  end

end
