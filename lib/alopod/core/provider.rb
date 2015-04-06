module Alopod

  class Provider

    require 'erb'

    class EnvironmentNotDefinedError < ArgumentError

      def initialize(path, env)
        super "The environment '#{env}' is not defined in #{path}."
      end

    end

    class InvalidConfigFilePathError < ArgumentError

      def initialize(path)
        super "The config file at #{path} does not exist!"
      end

    end

    class << self

      def configure(opts = {})
        config_path = opts[:config_file]
        environment = opts[:environment]

        path = Pathname.new(config_path)
        fail(InvalidConfigFilePathError, config_path) unless path.file?

        content = ERB.new(path.read)
        config  = Hashie::Mash.new YAML.load(content.result)

        fail(EnvironmentNotDefinedError, config_path, environment) unless config[environment]

        provider = config[environment][:provider]

        # TODO: check if provider is supported
        require "alopod/#{provider}/#{provider}"

        Alopod.const_get(provider.to_s.camelize).new(opts.merge(name: provider))
      end

    end

    private

    def environment
      @environment
    end

    def get_service_obj(service_name)
      @services ||= {}

      @services[service_name] ||= Service.new(
        provider: name,
        service:  service_name,
        log_file: log_file
      )

      @services[service_name]
    end

    def log_file
      @log_file
    end

    def name
      @name
    end

  end

end
