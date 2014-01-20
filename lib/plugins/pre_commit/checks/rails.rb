require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Rails < Plugin

      def self.includes
        [:ruby, :jshint, :console_log, :migration]
      end

      def self.description
        "Plugins common for ruby on rails."
      end

    end
  end
end
