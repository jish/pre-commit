require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class MergeConflict < Grep

      def message
        "detected a merge conflict\n"
      end

      def pattern
        "'<<<<<<<'"
      end

    end
  end
end
