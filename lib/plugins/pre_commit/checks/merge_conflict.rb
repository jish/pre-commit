require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class MergeConflict < Grep

      def message
        "detected a merge conflict"
      end

      def pattern
        "<<<<<<<"
      end

      def self.description
        "Finds files with unresolved merge conflicts."
      end

    end
  end
end
