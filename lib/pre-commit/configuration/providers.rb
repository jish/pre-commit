module PreCommit
  class NotAnArray < StandardError
  end

  class Configuration
    class Providers

      def initialize(pluginator, plugins = nil)
        @pluginator = pluginator
        @plugins    = plugins
      end

      def [](name)
        plugins.map{|plugin| plugin[name] }.compact.last
      end

      def update(plugin_name, name, value = nil)
        plugin = find_update_plugin(plugin_name)
        name   = name.to_sym
        value  = yield(plugin[name]) if block_given?
        plugin.update(name, value)
      end

      def update_add(plugin_name, name, list)
        update(plugin_name, name) do |value|
          value ||= []
          raise PreCommit::NotAnArray.new unless Array === value
          value + list
        end
      end

      def update_remove(plugin_name, name, list)
        update(plugin_name, name) do |value|
          value ||= []
          raise PreCommit::NotAnArray.new unless Array === value
          value - list
        end
      end

    private
      def plugins
        @plugins ||= @pluginator['configuration/providers'].sort_by(&:priority).map(&:new)
      end

      def find_update_plugin(plugin_name)
        plugin = plugins.detect{|plugin| plugin.class.name.split(/::/).last.downcase == plugin_name.to_s}
        raise "Plugin not found for #{plugin_name}." unless plugin
        plugin
      end

    end
  end
end
