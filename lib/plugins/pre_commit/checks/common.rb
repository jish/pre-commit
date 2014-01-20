require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Common < Plugin

      def self.includes
        [:tabs, :nb_space, :whitespace, :merge_conflict, :debugger]
      end

      def self.description
        "Plugins common for all languages."
      end

    end
  end
end
