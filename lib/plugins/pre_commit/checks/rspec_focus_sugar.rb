require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class RspecFocusSugar < Grep

      def files_filter(staged_files)
        staged_files.grep(/_spec\.rb$/)
      end

      def message
        ":syntactic sugar fdescribe|fcontext|fit for focus found in specs:"
      end

      def pattern
        "(fdescribe|fcontext|fit).*(\"|').*(\"|').*do"
      end

      def self.description
        "Finds ruby specs with syntactic sugar versions of focus: fdescribe|fcontext|fit."
      end

    end
  end
end
