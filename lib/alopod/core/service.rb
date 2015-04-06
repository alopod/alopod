module Alopod

  class Service

    class ProviderNotDefinedError < StandardError

      def initialize
        super ':provider is not defined.'
      end

    end

    class ServiceNameNotDefinedError < StandardError

      def initialize
        super ':service is not defined.'
      end

    end

    attr_reader :service,
                :provider

    def initialize(opts = {})
      @provider = opts[:provider] || (fail ProviderNotDefinedError)
      @service  = opts[:service]  || (fail ServiceNameNotDefinedError)
      @log_file = opts[:log_file]
    end

    def request(request_name, options = {}, &params)
      request_class = find_request(request_name, options[:api_version])
    end

    private

    def find_request(name, api_version = nil)
      base_namespace = Alopod.const_get(provider.camelize)
                             .const_get(service.camelize)

      api_version &&= api_version.to_s.camelize
    end

    def http_connection
      @http_connection ||= Faraday.new do |conn|
        conn.use     Logger.configure(log_file) if log_file
        conn.adapter Faraday.default_adapter

        conn.headers['Content-Type'] = 'application/json'
      end
    end

  end

end
