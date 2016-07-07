require 'spec_helper'

class WrongRequest < PrepaidfactoryApi::Requests::Base
end

class FakeRequest
end

describe PrepaidfactoryApi::Client do

  describe 'request' do

    p "FakeRequest #{FakeRequest.new.to_hash}"

    it 'can handle a unknown operation' do
      expect {
        CLIENT.request(:unknown_operation, PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['ppf']['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::UnknownOperation)
    end

    it 'can handle a known operation with a wrong request object' do
      expect {
        CLIENT.request(:get_product_information, WrongRequest.new)
      }.to raise_error(PrepaidfactoryApi::SOAPFault)
    end

    it 'can handle a unknown operation with a fake request object' do
      expect {
        CLIENT.request(:unknown_operation, FakeRequest.new)
      }.to raise_error(PrepaidfactoryApi::MalformedRequestObject)
    end

  end

end
