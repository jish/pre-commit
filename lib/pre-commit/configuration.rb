require 'pluginator'
require 'pre-commit/configuration/providers'

module PreCommit
  class Configuration

    class NotAnArray < StandardError
    end

    def initialize(pluginator, providers = nil)
      @providers = (providers or Providers.new(pluginator))
    end

    def get(name)
      @providers[name.to_sym]
    end

    def get_arr(name)
      value = get(name)
      case value
      when nil   then []
      when Array then value
      else raise NotAnArray.new
      end
    end

    def get_combined(name)
      get_arr(name) + get_arr("#{name}_add") - get_arr("#{name}_remove")
    end

    def list
      <<-DATA
Default checks: #{get_arr(:checks).join(" ")}
Enabled checks: #{get_combined(:checks).join(" ")}
Default warnings: #{get_arr(:warnings).join(" ")}
Enabled warnings: #{get_combined(:warnings).join(" ")}
DATA
    end

    def enable(*args)
    end

    def disable(*args)
    end

  end
end
