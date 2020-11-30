require 'faraday'
require 'digest'
require 'openssl'
require 'tencent/cloud/sms'


module Tencent
  module Cloud
    #
    # create tencent cloud api client. request need different instance
    #
    # > client = Tencent::Cloud.client.new 'region', 'secret_id', 'secret_key'
    # > client.swith_to 'cvm', 'cvm.tencentcloudapi.com' # optional. for quick api call will use defualt
    # > client.post json_text # text or hash, hash will use MultiJson.dump to convert
    # 
    class Client
      attr_reader :host, :service, :secret_id, :secret_key, :region, :options

      include Sms

      def initialize(region, secret_id, secret_key, **options)
        @secret_id = secret_id
        @region = region
        @secret_key = secret_key
        @options = options
      end

      def switch_to(service, host)
        @service = service
        @host = host
      end

      def connection
        Faraday.new(url: host) do |conn|
          conn.request :retry
          conn.request :url_encoded
          conn.response :logger
          conn.response :raise_error
          conn.adapter :net_http
        end
      end

      def post(body = nil, headers = nil)
        url = "https://#{host}"
        params = body.is_a?(Hash) ? MultiJson.dump(body) : body
        res = connection.post(url, params, headers)
        json(res.body)
      end

      def json(data)
        MultiJson.load data, symbolize_keys: true
      end

      def authorization(signature)
        [
          algorithm, ' ',
          'Credential=', secret_id, '/', credential_scope, ', ',
          'SignedHeaders=', signed_headers, ', ',
          'Signature=', signature
        ].join
      end

      def algorithm
        'TC3-HMAC-SHA256'
      end

      def sign_version
        'tc3_request'
      end

      def credential_scope
        [sign_date, service, sign_version].join('/')
      end

      def canonical_headers
        {
          'content-type' => 'application/json; charset=utf-8',
          'host' => host
        }.map { |p| p.join(':') }.join("\n") + "\n"
      end

      def signed_headers
        %w[content-type host].join(';')
      end

      def hashed_request_payload(request_payload)
        hash_sha256(request_payload)
      end

      def hashed_canonical_request(request_method, hashed_request_payload)
        res = [
          request_method, '/', '',
          canonical_headers, signed_headers,
          hashed_request_payload
        ].join("\n")
        hash_sha256(res)
      end

      def signature(request_method, request_payload)
        hashed = hashed_request_payload(request_payload)
        data = hashed_canonical_request(request_method, hashed)
        content =
          hmac_sha256(
            secret_signing,
            string_to_sign(request_method, data)
          )
        hex_encode(content)
      end

      def sign_date
        sign_time.strftime '%F'
      end

      def sign_time
        @sign_time ||= Time.now.getutc
      end

      def sign_timestamp
        sign_time.to_i
      end

      def secret_signing
        secret_service = hmac_sha256(sign_date, service)
        hmac_sha256(secret_service, sign_version)
      end

      def string_to_sign(hashed_canonical_request)
        timestamp = sign_timestamp
        [algorithm, timestamp, credential_scope, hashed_canonical_request].join("\n")
      end

      def hex_encode(content)
        Digest.hexencode content
      end

      def hash_sha256(data)
        Digest::SHA256.hexdigest(data).downcase
      end

      def hmac_sha256(key, data)
        OpenSSL::HMAC.hexdigest('sha256', key, data)
      end
    end
  end
end
