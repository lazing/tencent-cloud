require 'logger'

module Tencent
  module Cloud

    def self.logger
      @@logger ||= defined?(Rails) ? Rails.logger : ::Logger.new(STDOUT)
    end

    def self.logger=(logger)
      @@logger = logger
    end
  end
end

require 'tencent/cloud/client'
require 'tencent/cloud/sms_api'
