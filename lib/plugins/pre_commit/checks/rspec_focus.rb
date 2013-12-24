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
        "':focus'"
      end

    end
  end
end
