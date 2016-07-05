require 'spec_helper'

class FakeRequest
end

describe PrepaidfactoryApi::Client do

  describe 'request' do

    it 'can handle a unknown operation' do
      expect {
        CLIENT.request(:unknown_operation, PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['ppf']['retailer_id']))
      }.to raise_error(PrepaidfactoryApi::UnknownOperation)
    end

    it 'can handle a known operation with a fake request' do
      expect {
        CLIENT.request(:get_product_information, FakeRequest.new)
      }.to raise_error(PrepaidfactoryApi::WrongRequestObject)
    end

    it 'can handle a unknown operation with a fake request object' do
      expect {
        CLIENT.request(:unknown_operation, FakeRequest.new)
      }.to raise_error(PrepaidfactoryApi::MalformedRequestObject)
    end

  end

end
