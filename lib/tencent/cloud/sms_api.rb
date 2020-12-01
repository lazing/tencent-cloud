module Tencent
  module Cloud
    class SmsApi < Client

      def initialize(*args)
        super(*args)
        switch_to('sms', 'sms.tencentcloudapi.com')
      end

      ##
      # Send SMS to client
      #
      # @param numbers [Array] client numbers in format +[country_code][number]
      # @param template_id [String] sms template id
      # @param params [Array] sms template params
      # @param sign [String] optional for china local message
      # @param args [Hash] other api parameters
      def send_sms(numbers, template_id, params, sign = nil, **args)
        headers = { Action: 'SendSms' }.merge(share_headers)
        datus = {
          PhoneNumberSet: numbers, TemplateID: template_id,
          Sign: sign, TemplateParamSet: params
        }
        datus.merge!(args) if args
        post(datus, headers)
      end

      def describe_sms_sign_list(list, international)
        headers = { Action: 'DescribeSmsSignList' }.merge(share_headers)
        datus = { SignIdSet: list, International: international }
        post(datus, headers)
      end

      def share_headers
        { Version: '2019-07-11', SmsSdkAppid: options[:SmsSdkAppid].to_s }
      end
    end
  end
end
