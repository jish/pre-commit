require 'pluginator'
require 'pre-commit/configuration'
require 'plugins/pluginator/extensions/conversions'
require 'pre-commit/plugins_list'

module PreCommit
  class ListEvaluator
    include Pluginator::Extensions::Conversions

    attr_reader :config

    def initialize(config)
      @config = config
    end

    def list
      <<-DATA
Available providers: #{config.providers.list.join(" ")}
Available checks   : #{plugin_names.join(" ")}
Default   checks   : #{config.get_arr(:checks).join(" ")}
Enabled   checks   : #{checks_config.join(" ")}
Evaluated checks   : #{checks_evaluated.join(" ")}
Default   warnings : #{config.get_arr(:warnings).join(" ")}
Enabled   warnings : #{warnings_config.join(" ")}
Evaluated warnings : #{warnings_evaluated.join(" ")}
DATA
    end

    def plugins
      list = config.pluginator['checks'].map{|plugin| [class2string(class2name(plugin)), plugin] }.sort
      separator = list.map{|name, plugin| name.length }.max
      list.map{ |name, plugin| format_plugin(name, separator, plugin) }.flatten
    end

    def checks_config
      get_combined_checks - get_arr_checks_remove
    end

    def checks_evaluated(type = :evaluated_names)
      PreCommit::PluginsList.new(get_combined_checks, get_arr_checks_remove) do |name|
        config.pluginator.find_check(name)
      end.send(type)
    end

    def warnings_config
      get_combined_warnings - get_arr_warnings_remove
    end

    def warnings_evaluated(type = :evaluated_names)
      PreCommit::PluginsList.new(get_combined_warnings, get_arr_warnings_remove) do |name|
        config.pluginator.find_check(name)
      end.send(type)
    end

  private

    def plugin_names
      config.pluginator['checks'].map{|plugin| class2string(class2name(plugin)) }.sort
    end

    def format_plugin(name, separator, plugin)
      line = [sprintf("%#{separator}s : %s", name, plugin.description)]
      line << sprintf("%#{separator}s - includes: %s", "", plugin.includes.join(" ")) if plugin.respond_to?(:includes)
      line << sprintf("%#{separator}s - excludes: %s", "", plugin.excludes.join(" ")) if plugin.respond_to?(:excludes)
      line
    end

    def get_combined_checks
      @get_combined_checks     ||= config.get_combined(:checks)
    end

    def get_arr_checks_remove
      @get_arr_checks_remove   ||= config.get_arr("checks_remove")
    end

    def get_combined_warnings
      @get_combined_warnings   ||= config.get_combined(:warnings)
    end

    def get_arr_warnings_remove
      @get_arr_warnings_remove ||= config.get_arr("warnings_remove")
    end

  end
end
