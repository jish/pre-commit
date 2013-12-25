require 'pluginator'
require 'pre-commit/configuration/providers'
require 'plugins/pluginator/extensions/conversions'

module PreCommit
  class Configuration
    include Pluginator::Extensions::Conversions

    def initialize(pluginator, providers = nil)
      @pluginator = (pluginator or Pluginator.find('pre_commit'))
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
      get_arr(name) + get_arr("#{name}_add") - get_arr("#{name}_remove")
    end

    def list
      <<-DATA
Available providers: #{plugin_names("configuration/providers")}
Available checks   : #{plugin_names("checks")}
Default   checks   : #{get_arr(:checks).join(" ")}
Enabled   checks   : #{get_combined(:checks).join(" ")}
Default   warnings : #{get_arr(:warnings).join(" ")}
Enabled   warnings : #{get_combined(:warnings).join(" ")}
DATA
    end

    def enable(plugin_name, type, check1, *checks)
      checks.unshift(check1) # check1 is ArgumentError triger
      checks.map!(&:to_sym)
      @providers.update_remove( plugin_name, "#{type}_remove", checks )
      @providers.update_add(    plugin_name, "#{type}_add",    checks )
      true
    rescue PreCommit::PluginNotFound => e
      $stderr.puts e
      false
    end

    def disable(plugin_name, type, check1, *checks)
      checks.unshift(check1) # check1 is ArgumentError triger
      checks.map!(&:to_sym)
      @providers.update_remove( plugin_name, "#{type}_add",    checks )
      @providers.update_add(    plugin_name, "#{type}_remove", checks )
      true
    rescue PreCommit::PluginNotFound => e
      warn e
      false
    end

  private
    def plugin_names(type)
      @pluginator[type].map{|plugin| class2string(plugin.name.split(/::/).last) }.sort.join(" ")
    end

  end
end
