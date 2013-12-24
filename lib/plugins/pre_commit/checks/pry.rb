require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class Pry < Grep

      def message
        "binding.pry found:\n"
      end

      def pattern
        "binding\.pry"
      end

    end
  end
end
