module Alopod

  class Acaleph < Provider

    def initialize(opts = {})
      @name        = opts[:name]
      @environment = opts[:environment]
      @log_file    = opts[:log_file]
    end

    def method_missing(name, *args, &block)
      if service_names.include?(name)
        get_service_obj(name)
      else
        super name, *args, &block
      end
    end

    def service_names
      path = Pathname.new(__FILE__).join('..', name.to_s, '**')
      request_file_paths = Dir.glob(path.expand_path)

      @service_names =
        request_file_paths
          .collect { |rf| rf.to_s.match(/#{name}\/([\w]+)$/) }
          .collect { |rf| rf[1].split('/').first }
          .uniq
    end

  end

end
