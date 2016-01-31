require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Go < Plugin

      def self.includes
        [:gobuild, :gofmt]
      end


      def self.description
        "Plugins for Go code"
      end
    end
  end
end
