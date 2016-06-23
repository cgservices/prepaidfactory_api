# require 'spec_helper'
#
# describe PrepaidfactoryApi::Order do
#
#   describe '#create' do
#     describe 'is possible to create an order' do
#
#       describe 'cancelable' do
#         order = PrepaidfactoryApi::Order.new
#         order.cancelable = true
#
#         it('(SSC10) SSC 10 euro, max field length') { fail order.create('RSPEC_TEST', 'SSC10') }
#         it('(SSC20) SSC 20 euro, different instructions on every call') { order.create('RSPEC_TEST', 'SSC20') }
#         it('(SSC30) SSC 30 euro, returns error not found on cancelation or confirmation') { order.create('RSPEC_TEST', 'SSC30') }
#         it('(SSC40) SSC 40 euro, returns error not found on order creation') { fail order.create('RSPEC_TEST', 'SSC40') }
#         it('(SSC50) SSC 50 euro, always returns out of stock') { fail order.create('RSPEC_TEST', 'SSC50') }
#       end
#     end
#   end
#
#   # describe '#confirm' do
#   #   it 'is possible to confirm an order' do
#   #
#   #     describe 'cancelable' do
#   #       order = PrepaidfactoryApi::Order.new
#   #       order.cancelable = true
#   #
#   #       it('(SSC10) SSC 10 euro, max field length') { order.confirm( order.create('RSPEC_TEST', 'SSC10')[:orderId] ) }
#   #       it('(SSC20) SSC 20 euro, deze instructie teksten zijn iedere keer anders') { order.create('RSPEC_TEST', 'SSC20') }
#   #       it('(SSC30) SSC 30 euro, dit product geeft bij bevestiging/annulering altijd error not found') { order.create('RSPEC_TEST', 'SSC30') }
#   #       it('(SSC40) SSC 40 euro, dit product wordt wel terug gegeven in de product lijst maar kan nooit gevonden worden bij het orderen') { fail order.create('RSPEC_TEST', 'SSC40') }
#   #       it('(SSC50) SSC 50 euro, dit geeft altijd de foutmelding out of stock') { fail order.create('RSPEC_TEST', 'SSC50') }
#   #     end
#   #
#   #     describe 'not cancelable' do
#   #       order = PrepaidfactoryApi::Order.new
#   #       order.cancelable = false
#   #
#   #       it('(SSC10) SSC 10 euro, max field length') { order.create('RSPEC_TEST', 'SSC10') }
#   #       it('(SSC20) SSC 20 euro, deze instructie teksten zijn iedere keer anders') { order.create('RSPEC_TEST', 'SSC20') }
#   #       it('(SSC30) SSC 30 euro, dit product geeft bij bevestiging/annulering altijd error not found') { order.create('RSPEC_TEST', 'SSC30') }
#   #       it('(SSC40) SSC 40 euro, dit product wordt wel terug gegeven in de product lijst maar kan nooit gevonden worden bij het orderen') { fail order.create('RSPEC_TEST', 'SSC40') }
#   #       it('(SSC50) SSC 50 euro, dit geeft altijd de foutmelding out of stock') { fail order.create('RSPEC_TEST', 'SSC50') }
#   #     end
#   #
#   #   end
#   # end
#   #
#   # describe 'Order#cancel' do
#   #   it 'is possible to cancel an order' do
#   #     order = PrepaidfactoryApi::Order.new
#   #     order = product.getAll
#   #     expect(products.size).to be > 0
#   #   end
#   # end
#
# end
