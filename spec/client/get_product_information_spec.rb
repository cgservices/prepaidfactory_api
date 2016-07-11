require 'spec_helper'

describe PrepaidfactoryApi::Client do

  describe 'GetProductInformation' do

    it 'can retrieve products' do
      response = CLIENT.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['retailer_id']))
      expect(response).to be_an_instance_of(PrepaidfactoryApi::Responses::GetProductInformation)
      expect(response.entities.length).to be >= 1
    end

    it 'can handle a wrong retailer_id' do
      expect {
        response = CLIENT.getProductInformation(PrepaidfactoryApi::Requests::GetProductInformation.new('PPF-RETAILER-TEST-ID'))
      }.to raise_error(PrepaidfactoryApi::RetailerNotFound)
    end

    it 'can handle a wrong request object' do
      expect {
        CLIENT.getProductInformation(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::WrongRequestObject)
    end

  end

end
