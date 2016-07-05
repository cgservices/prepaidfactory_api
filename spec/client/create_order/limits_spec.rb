require 'spec_helper'

class FakeRequest < PrepaidfactoryApi::Requests::Base
end

describe PrepaidfactoryApi::Client do

  describe 'createOrder' do

    it 'can not create order if the limit has been reached' do
      expect {
        CLIENT.request(:get_product_information, PrepaidfactoryApi::Requests::CreateOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::SOAPFault)
    end

  end

end
