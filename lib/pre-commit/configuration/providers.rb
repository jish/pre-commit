module PreCommit
  class Configuration

    class Providers
      def initialize(pluginator)
        @pluginator = pluginator
      end
      def [](name)
        plugins.map{|plugin| plugin[name] }.compact.last
      end
      def plugins
        @plugins ||= @pluginator['configuration/providers'].sort_by(&:priority).map(&:new)
      end
    end

  end
end
