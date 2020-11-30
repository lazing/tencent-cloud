# Tencent::Cloud

腾讯云 QCloud API 3.0 Ruby SDK

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'tencent-cloud'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tencent-cloud

## Usage

```ruby
client = Tencent::Cloud::Client.new 'apguanzhou', 'AKIDz8krbsJ5yKBZQpn74WFkmLPx3*******', 'Gu5t9xGARNpq86cd98joQYCN3*******', SmsSdkAppid: 1234567890
client.switch_to 'cvm', 'cvm.tencentcloudapi.com' # 切换接口，设定服务和地址
response_body = client.post(a: 1, b: 2) # 响应报文体解析为Hash
client.post({a: 1, b: 2}, h1: 1, h2: 2) # 请求参数可以有两个：第一组Hash为报文体，第二组为头部

client.send_sms ['+8613912312345'], 1, ['code'], 'sign' # 实现常用方法包装

```

### 常用方法

#### SMS短信服务
详细内容参考`Tencent::Cloud::Sms` 或 `sms_spec.rb`

1. send_sms(numbers, template_id, params, sign = nil, **args)

## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/dianping-api.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
