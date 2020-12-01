require File.expand_path('../../../spec_helper', __FILE__)

RSpec.describe Tencent::Cloud::Client do

  subject do
    client = described_class.new 'apguanzhou', 'AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******', 'Gu5t9xGARNpq86cd98joQYCN3*******'
    client.switch_to 'cvm', 'cvm.tencentcloudapi.com'
    allow(client).to receive(:sign_date).and_return('2019-02-25')
    allow(client).to receive(:sign_timestamp).and_return(1_551_113_065.to_s)
    client
  end

  it :string_to_sign do
    hash_co_payload = '5ffe6a04c0664d6b969fab9a13bdab201d63ee709638e2749d62a09ca18d7031'
    result = <<-PAYLOAD
      TC3-HMAC-SHA256
      1551113065
      2019-02-25/cvm/tc3_request
      5ffe6a04c0664d6b969fab9a13bdab201d63ee709638e2749d62a09ca18d7031
    PAYLOAD
    expect(subject.string_to_sign(hash_co_payload)).to\
      eq(result.lines.map(&:strip).join("\n"))
  end

  it :signature do
    # secret_signing = '486d685475fe2688c1de7fb51acd4442ace854c4cc849965910b9ccbb4800762'
    string_to_sign = "TC3-HMAC-SHA256\n1551113065\n2019-02-25/cvm/tc3_request\n5ffe6a04c0664d6b969fab9a13bdab201d63ee709638e2749d62a09ca18d7031" 
   
    # allow(subject).to receive(:secret_signing).and_return(secret_signing)
    allow(subject).to receive(:string_to_sign).and_return(string_to_sign)
    result = '2230eefd229f582d8b1b891af7107b91597240707d778ab3738f756258d7652c'
    expect(subject.signature('', '')).to eq(result)
  end

  it :canonical_headers do
    result = "content-type:application/json; charset=utf-8\nhost:cvm.tencentcloudapi.com\n"
    expect(subject.canonical_headers).to eq(result)
  end

  it :hashed_canonical_request do
    result = '5ffe6a04c0664d6b969fab9a13bdab201d63ee709638e2749d62a09ca18d7031'
    hashed = '35e9c5b0e3ae67532d3c9f17ead6c90222632e5b1ff7f6e89887f1398934f064'
    expect(subject.hashed_canonical_request('POST', hashed)).to eq(result)
  end

  it :hashed_request_payload do
    result = '35e9c5b0e3ae67532d3c9f17ead6c90222632e5b1ff7f6e89887f1398934f064'
    data = '{"Limit": 1, "Filters": [{"Values": ["\u672a\u547d\u540d"], "Name": "instance-name"}]}'
    expect(subject.hashed_request_payload(data)).to eq(result)
  end

  it :authorization do
    result = \
      'TC3-HMAC-SHA256 Credential=AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******/2019-02-25/cvm/tc3_request, SignedHeaders=content-type;host, Signature=2230eefd229f582d8b1b891af7107b91597240707d778ab3738f756258d7652c'

    signature = '2230eefd229f582d8b1b891af7107b91597240707d778ab3738f756258d7652c'
    expect(subject.authorization(signature)).to eq(result)
  end

  it :method_missing do
    expect(subject.sms_api).to be_kind_of(Tencent::Cloud::SmsApi)
  end
end
