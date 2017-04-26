require 'spec_helper'

describe PrepaidfactoryApi::Client do
  # let(:france_products) do
  #   ['H1201', 'H1202', 'H1203', 'H1204', 'H1205', 'H1206', 'H1207', 'H1208', 'H1209', 'H1210', 'H1211', 'H1212', 'H1213', 'H1214', 'H1215', 'H1216', 'H1217', 'H1218', 'H1219', 'H1220', 'H1221', 'H1222', 'H1223', 'H1224', 'H1225', 'H1226', 'H1227', 'H1228', 'H1229', 'H1230', 'H1231', 'H1232', 'H1233', 'H1234', 'H1235', 'H1236', 'H1237', 'H1238', 'H1239', 'H1240', 'H1241', 'H1242', 'H1243', 'H1244', 'H1245', 'H1246', 'H1247', 'H1248', 'H1249', 'H1250', 'H1251', 'H1252', 'H1253', 'H1254', 'H1255', 'H1256', 'H1257', 'H1258', 'H1259', 'H1260', 'H1261', 'H1262', 'H1263', 'H1264', 'H1265', 'H1266', 'H1267', 'H1268', 'H1269', 'H1270', 'H1271', 'H1272', 'H1273', 'H1274', 'H1275', 'H1276', 'H1277', 'H1278', 'H1279', 'H1280', 'H1281', 'H1282', 'H1283', 'H0101', 'H0102', 'H0103', 'H0104', 'H0105', 'H0106', 'H0107', 'H0108', 'H0109', 'H0110', 'H0111', 'H0112', 'H0113', 'H0114', 'H0115', 'H0116', 'H0117', 'H0118', 'H0119', 'H0120', 'H0121', 'H0122', 'H0123']
  # end

  # let(:austria_products) do
  #   ['H0201', 'H0202', 'H0203', 'H0204', 'H0205', 'H0206', 'H0207', 'H0208', 'H0209', 'H0210', 'H0211', 'H0212', 'H0213', 'H0214', 'H0215', 'H0216', 'H0217', 'H0218', 'H0219', 'H0220', 'H0221', 'H0222', 'H0223', 'H0224', 'H0225', 'H0226', 'H0227', 'H0228', 'H0229', 'H0230', 'H0231', 'H0232', 'H0233', 'H0234', 'H0235', 'H0236', 'H0237', 'H0238', 'H0239', 'H0240', 'H0241']
  # end

  let(:france_products) { [PRODUCT] }
  let(:austria_products) { [PRODUCT] }

  describe '#create_order' do
    xit 'orders all france test products at once' do
      france_products.each do |product_code|
        response = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], product_code, TERMINAL))
        expect(response.vouchers.first[:activation_code]).to match(/^\d{4}-\d{4}-\d{4}-\d{4}$/)
      end
    end

    xit 'orders all austria test products at once' do
      austria_products.each do |product_code|
        response = CLIENT.create_order(PrepaidfactoryApi::Requests::CreateOrder.new(CONFIG['retailer_id'], product_code, TERMINAL))
        expect(response.vouchers.first[:activation_code]).to match(/^\d{4}-\d{4}-\d{4}-\d{4}$/)
      end
    end
  end
end
