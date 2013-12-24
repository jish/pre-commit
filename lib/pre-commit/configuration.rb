require 'pluginator'
require 'pre-commit/configuration/providers'

module PreCommit
  class Configuration

    def initialize(pluginator, providers = nil)
      @providers = (providers or Providers.new(pluginator))
    end

    def get(name)
      @providers[name.to_sym]
    end

    def get_arr(name)
      get(name) or []
    end

    def get_combined(name)
      get_arr(name) + get_arr("#{name}_add") - get_arr("#{name}_remove")
    end

  end
end
