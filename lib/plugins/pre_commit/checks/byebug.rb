require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Byebug < Grep

      def files_filter(staged_files)
        staged_files.reject { |file| File.basename(file) =~ /^Gemfile/ }
      end

      def message
        "byebug statement(s) found:"
      end

      def pattern
        "^.*byebug"
      end

      def self.description
        "Finds files with 'byebug'."
      end

    end
  end
end
