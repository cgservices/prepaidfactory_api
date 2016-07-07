require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe 'GetProductInformation' do

    it 'can retrieve products' do
      expect {
        CLIENT.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['ppf']['retailer_id']))
      }.to be_a_success
    end

    it 'can handle a wrong retailer_id' do
      expect {
        CLIENT.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new('PPF-RETAILER-TEST-ID'))
      }.to raise_error(PrepaidfactoryApi::RetailerNotFound)
    end

    it 'can handle a wrong request object' do
      expect {
        CLIENT.getProductInformation(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::WrongRequestObject)
    end

  end

end
