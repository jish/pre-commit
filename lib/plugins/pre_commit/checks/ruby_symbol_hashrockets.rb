require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class RubySymbolHashrockets < Grep

      def message
        "detected :symbol => value hashrocket:\n"
      end

      def pattern
        '\'[^:](:{1}(?:\$|@|@@|[_A-Za-z])?\w*[=!?]?\s*=>\s*)\''
      end

    end
  end
end
