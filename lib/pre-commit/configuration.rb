require 'pluginator'
require 'pre-commit/configuration/providers'
require 'plugins/pluginator/extensions/conversions'
require 'pre-commit/plugins_list'

module PreCommit
  class Configuration
    include Pluginator::Extensions::Conversions

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

    def list
      <<-DATA
Available providers: #{@providers.list.join(" ")}
Available checks   : #{plugin_names.join(" ")}
Default   checks   : #{get_arr(:checks).join(" ")}
Enabled   checks   : #{checks_config.join(" ")}
Evaluated checks   : #{checks_evaluated.join(" ")}
Default   warnings : #{get_arr(:warnings).join(" ")}
Enabled   warnings : #{warnings_config.join(" ")}
Evaluated warnings : #{warnings_evaluated.join(" ")}
DATA
    end

    def plugins
      list = @pluginator['checks'].map{|plugin| [class2string(class2name(plugin)), plugin.description] }.sort
      separator = list.map{|name, description| name.length }.max
      list.map{|name, description| sprintf("%#{separator}s : %s", name, description) }
    end

    def enable(plugin_name, type, check1, *checks)
      checks.unshift(check1) # check1 is ArgumentError triger
      checks.map!(&:to_sym)
      @providers.update_remove( plugin_name, "#{type}_remove", checks )
      @providers.update_add(    plugin_name, "#{type}_add",    (checks or []) - (@providers.default(type) or []) )
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

    def checks_config
      get_combined_checks - get_arr_checks_remove
    end

    def checks_evaluated(type = :evaluated_names)
      PreCommit::PluginsList.new(get_combined_checks, get_arr_checks_remove) do |name|
        @pluginator.find_check(name)
      end.send(type)
    end

    def warnings_config
      get_combined_warnings - get_arr_warnings_remove
    end

    def warnings_evaluated(type = :evaluated_names)
      PreCommit::PluginsList.new(get_combined_warnings, get_arr_warnings_remove) do |name|
        @pluginator.find_check(name)
      end.send(type)
    end

  private

    def get_combined_checks
      @get_combined_checks     ||= get_combined(:checks)
    end

    def get_arr_checks_remove
      @get_arr_checks_remove   ||= get_arr("checks_remove")
    end

    def get_combined_warnings
      @get_combined_warnings   ||= get_combined(:warnings)
    end

    def get_arr_warnings_remove
      @get_arr_warnings_remove ||= get_arr("warnings_remove")
    end

    def plugin_names
      @pluginator['checks'].map{|plugin| class2string(class2name(plugin)) }.sort
    end

  end
end
