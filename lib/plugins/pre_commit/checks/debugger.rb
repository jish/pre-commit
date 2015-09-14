require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Debugger < Grep

      def files_filter(staged_files)
        staged_files.reject { |file| File.basename(file) =~ /^Gemfile/ }
      end

      def message
        "debugger statement(s) found:"
      end

      def pattern
        "^[ 	]*(debugger|byebug)"
      end

      def self.description
        "Finds files with 'debugger'."
      end

    end
  end
end
