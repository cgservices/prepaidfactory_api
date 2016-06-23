require 'spec_helper'
=begin
describe PrepaidfactoryApi::Product do

  describe 'Product#getAll' do
    it 'can retrieve products' do
      product = PrepaidfactoryApi::Product.new
      products = product.getAll
      expect(products.size).to be > 0
    end
  end

end
=end
