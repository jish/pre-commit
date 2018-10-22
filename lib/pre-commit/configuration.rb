require 'pluginator'
require 'pre-commit/configuration/providers'
require 'pre-commit/plugins_list'

module PreCommit
  class Configuration
    attr_reader :pluginator, :providers

    def initialize(pluginator, providers = nil)
      @pluginator = (pluginator or PreCommit.pluginator)
      @providers  = (providers  or Providers.new(@pluginator))
    end

    def get(name)
      @providers[name.to_sym]
    end

    def get_arr(name)
      value = get(name)
      case value
      when nil   then []
      when Array then value
      else raise PreCommit::NotAnArray.new
      end
    end

    def get_combined(name)
      get_arr(name) + get_arr("#{name}_add")
    end

    def enable(plugin_name, type, check1, *checks)
      checks.unshift(check1) # check1 is ArgumentError triger
      checks.map!(&:to_sym)
      @providers.update( plugin_name, "#{type}_remove", :-, checks )
      @providers.update( plugin_name, "#{type}_add",    :+, (checks or []) - (@providers.default(type) or []) )
      true
    rescue PreCommit::PluginNotFound => e
      $stderr.puts e
      false
    end

    def disable(plugin_name, type, check1, *checks)
      checks.unshift(check1) # check1 is ArgumentError triger
      checks.map!(&:to_sym)
      @providers.update( plugin_name, "#{type}_add",    :-, checks )
      @providers.update( plugin_name, "#{type}_remove", :+, checks )
      true
    rescue PreCommit::PluginNotFound => e
      warn e.message
      false
    end

  end
end
