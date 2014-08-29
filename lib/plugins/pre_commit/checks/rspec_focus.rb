require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class RspecFocus < Grep

      def files_filter(staged_files)
        staged_files.grep(/_spec\.rb$/)
      end

      def message
        ":focus found in specs:\n"
      end

      def pattern
        "'^\s*(describe|context|it).*(:focus|focus:).*do$'"
      end

      def self.description
        "Finds ruby specs with ':focus'."
      end

    end
  end
end
