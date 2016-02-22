require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Pry < Grep

      def message
        "binding.pry found:"
      end

      def pattern
        "binding\.(remote_)?pry"
      end

      def self.description
        "Finds files with 'binding.pry'."
      end

    end
  end
end
