require File.expand_path('../../../spec_helper', __FILE__)

RSpec.describe Tencent::Cloud::Sms do

  subject do
    client = Tencent::Cloud::Client.new 'ap-guanzhou', 'AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******', 'Gu5t9xGARNpq86cd98joQYCN3*******'
    allow(client).to receive(:sign_date).and_return('2019-02-25')
    allow(client).to receive(:sign_timestamp).and_return(1_551_113_065)
    client
  end

  it :send_sms do
    stub_request(:post, 'https://sms.tencentcloudapi.com/')
    subject.send_sms ['+8613912312345'], 1, ['code'], 'Sign'
  end

end
