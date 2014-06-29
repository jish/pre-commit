require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Debugger < Grep

      def files_filter(staged_files)
        staged_files.reject { |file| File.basename(file) =~ /^Gemfile/ }
      end

      def message
        "debugger statement(s) found:\n"
      end

      def pattern
        '-e "^[ 	]*debugger"'
      end

      def self.description
        "Finds files with 'debuger'."
      end

    end
  end
end
