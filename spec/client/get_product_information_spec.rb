require 'spec_helper'

describe PrepaidfactoryApi::Client do
  describe 'get_product_information' do
    it 'can retrieve products' do
      response = CLIENT.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['retailer_id']))
      expect(response).to be_an_instance_of(PrepaidfactoryApi::Responses::GetProductInformation)
      expect(response.entities.length).to be >= 1

      expect {
        response = CLIENT.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new(CONFIG['retailer_id']))
        response.each { |product|
          puts "#{product.product_id.to_s.ljust(5)}: #{product.description}"
        }
      }.to_not raise_error
    end

    xit 'can handle a wrong retailer_id' do
      expect {
        CLIENT.get_product_information(PrepaidfactoryApi::Requests::GetProductInformation.new('PPF-RETAILER-TEST-ID'))
      }.to raise_error(PrepaidfactoryApi::OperationRetailerNotFound)
    end

    it 'can handle a wrong request object' do
      expect {
        CLIENT.get_product_information(PrepaidfactoryApi::Requests::ConfirmOrder.new(0))
      }.to raise_error(PrepaidfactoryApi::OperationMalformedRequest)
    end
  end
end
