require 'logger'

module Tencent
  module Cloud

    def self.logger
      @@logger ||= defined?(Rails) ? Rails.logger : ::Logger.new(STDOUT)
    end

    def self.logger=(logger)
      @@logger = logger
    end

    def self.client
      return @client = yield(Client) if block_given?

      @client || raise(::Tencent::Cloud::Error, 'initialize client with block first')
    end
  end
end

require 'tencent/cloud/client'
require 'tencent/cloud/sms_api'
