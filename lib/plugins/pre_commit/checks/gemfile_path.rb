require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class GemfilePath < Grep

      def files_filter(staged_files)
        staged_files.grep(/^Gemfile$/)
      end

      def message
        "local path found in Gemfile:\n"
      end

      def pattern
        "'path:|:path\\s*=>'"
      end

      def extra_grep
        " | grep -v '#'"
      end

      def self.description
        "Checks 'Gemfile' for local paths."
      end

    end
  end
end
