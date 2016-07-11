require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe 'request' do

    it 'can handle a unknown operation' do
      expect {
        CLIENT.request(:unknown_operation, PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::UnknownOperation)
    end

    it 'can handle a known operation with a wrong request object' do
      expect {
        CLIENT.request(:get_product_information, WrongRequest.new)
      }.to raise_error(PrepaidfactoryApi::SOAPFault)
    end

    it 'can handle a unknown operation with a unknown request object' do
      expect {
        CLIENT.request(:unknown_operation, FakeRequest.new)
      }.to raise_error(PrepaidfactoryApi::MalformedRequestObject)
    end

  end

end
