require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'request' do
    it 'can handle a unknown operation' do
      expect {
        CLIENT.request(:unknown_operation,
                       PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::OperationUnknownRequestObject)
    end

    it 'can handle a known operation with a wrong request object' do
      expect {
        CLIENT.request(:get_product_information,
                       PrepaidfactoryApi::Requests::WrongRequest.new)
      }.to raise_error(PrepaidfactoryApi::OperationMalformedRequest)
    end

    it 'can handle a unknown operation with a unknown request object' do
      expect {
        CLIENT.request(:fake_request,
                       PrepaidfactoryApi::Requests::FakeRequest.new)
      }.to raise_error(PrepaidfactoryApi::OperationUnknownRequestObject)
    end
  end
end
