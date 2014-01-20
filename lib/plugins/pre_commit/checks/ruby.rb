require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Ruby < Plugin

      def self.includes
        [:pry, :local]
      end

      def self.description
        "Plugins common for ruby."
      end

    end
  end
end
