require "plugins/pluginator/extensions/conversions"

module Pluginator::Extensions
  # Extension to find class or first plugin that answers the question with true or to print warning
  module FindCheck
    include Conversions

    def find_check(name)
      klass = string2class(name)
      @plugins["checks"].detect do |plugin|
        plugin_short_name(plugin) == klass ||
        plugin.respond_to?(:aliases) && plugin.public_send(:aliases).include?(name.to_sym)
      end ||
      begin
        $stderr.puts "Could not find plugin supporting #{name} / #{klass},
available plugins: #{available_plugins}"
        nil
      end
    end

    def plugin_short_name(plugin)
      plugin.name.split('::').last
    end

    def available_plugins
      @plugins["checks"].map{|plugin| plugin_short_name(plugin)}.join(", ")
    end

  end
end
