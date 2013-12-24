require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Tabs < Grep

      def message
        "detected tab before initial space:\n"
      end

      def pattern
        "'^ *\t'"
      end

    end
  end
end
