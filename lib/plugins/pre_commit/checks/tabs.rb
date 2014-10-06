require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Tabs < Grep

      def message
        "detected tab before initial space:"
      end

      def pattern
        "^ *\t"
      end

      def self.description
        "Finds ruby files with tabulation character before text in line."
      end

    end
  end
end
