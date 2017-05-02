require 'plugins/pluginator/extensions/conversions'

module PreCommit
  class NotAnArray < StandardError
  end

  class PluginNotFound < StandardError
  end

  class Configuration
    class Providers
      include Pluginator::Extensions::Conversions

      def initialize(pluginator, plugins = nil)
        @pluginator = pluginator
        @plugins    = plugins
      end

      def [](name)
        plugins.map{|plugin| plugin[name] }.compact.last
      end

      def default(name)
        plugins[0][name]
      end

      def update(plugin_name, name, operation, list)
        plugin = find_update_plugin(plugin_name)
        name   = name.to_sym
        value = plugin[name] || []
        raise PreCommit::NotAnArray.new unless Array === value
        value = value.send(operation, list)
        plugin.update(name, value)
      end

      def list
        plugins.map{|plugin| "#{class2string(class2name(plugin.class))}(#{plugin.class.priority})" }
      end

    private
      def plugins
        @plugins ||= @pluginator['configuration/providers'].sort_by(&:priority).map(&:new)
      end

      def find_update_plugin(plugin_name)
        plugins.detect{|plugin| class2string(class2name(plugin.class)) == plugin_name.to_s} || raise(PluginNotFound.new("Plugin not found for #{plugin_name}."))
      end

    end
  end
end
