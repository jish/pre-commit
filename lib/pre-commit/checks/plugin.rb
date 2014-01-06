module PreCommit
  module Checks
    class Plugin
      attr_accessor :pluginator, :config

      def initialize(pluginator, config)
        @pluginator = pluginator
        @config     = config
      end
    end
  end
end
