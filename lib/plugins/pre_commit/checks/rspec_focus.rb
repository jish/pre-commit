require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class RspecFocus < Grep

      def files_filter(staged_files)
        staged_files.grep(/_spec\.rb$/)
      end

      def message
        "focus found in specs:"
      end

      def pattern
        "(describe|context|it).*(:focus|focus:).*do"
      end

      def extra_pattern
        "(fdescribe|fcontext|fit).*(\"|').*(\"|').*do"
      end

      def self.description
        "Finds ruby specs that are focused."
      end

    end
  end
end
