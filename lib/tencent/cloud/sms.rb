module Tencent
  module Cloud
    module Sms

      def module_post(body = nil, headers = nil)
        switch_to('sms', 'sms.tencentcloudapi.com')
        post(body, headers)
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
        datus = { Action: 'SendSms', Version: '2019-07-11', SmsSdkAppid: options[:SmsSdkAppid] }
        datus.merge!\
          PhoneNumberSet: numbers, TemplateID: template_id,
          Sign: sign, TemplateParamSet: params
        data.merge!(args) if args
        module_post(datus)
      end
    end
  end
end
