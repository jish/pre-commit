require 'plugins/pluginator/extensions/conversions'
require 'pre-commit/checks/plugin/config_file'

module PreCommit
  module Checks
    class Plugin
      include Pluginator::Extensions::Conversions

      attr_accessor :pluginator, :config

      def initialize(pluginator, config, list)
        @pluginator = pluginator
        @config     = config
        @list       = list
      end

      def name
        class2string(class2name(self.class))
      end

    private

      def config_file
        @config_file ||= ConfigFile.new(name, config, alternate_config_file)
        @config_file.location
      end

      def alternate_config_file
        ''
      end
    end
  end
end
