require 'pluginator'
require 'pre-commit/configuration/providers'

module PreCommit
  class Configuration
    def initialize(pluginator, providers = nil)
      @providers = providers || Providers.new(pluginator)
    end

    def get(name)
      symbolize(@providers[name])
    end

    def get_arr(name)
      ensure_arr(@providers[name])
    end

    def get_combined_arr(name)
      get_arr(name) + get_arr("#{name}_add".to_sym) - get_arr("#{name}_remove".to_sym)
    end

  private

    def ensure_arr(value)
      case value
      when Array
        value
      when String
        str2arr(value)
      when nil
        []
      else
        raise "do not know how to handle #{value.class}:'#{value}'"
      end
    end

    def str2arr(string)
      string.split(/, ?/).map{|string| symbolize(string.chomp.strip) }
    end

    def symbolize(string)
      if string =~ /:(.*)/
      then $1.to_sym
      else string
      end
    end

  end
end
