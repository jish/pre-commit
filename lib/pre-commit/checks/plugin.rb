module PreCommit
  module Checks
    class Plugin
      attr_accessor :pluginator, :config

      def initialize(pluginator, config, list)
        @pluginator = pluginator
        @config     = config
        @list       = list
      end
    end
  end
end
