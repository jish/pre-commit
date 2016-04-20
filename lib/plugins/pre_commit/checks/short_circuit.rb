require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class ShortCircuit < Grep
      def message
        "Logical short circuit found:"
      end

      def pattern
        "^.*([true|false] \&\&)"
      end

      def self.description
        "Finds files with a logical short circuit like 'if true &&'"
      end

    end
  end
end
