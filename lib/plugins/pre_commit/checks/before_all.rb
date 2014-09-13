require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class BeforeAll < Grep

      def files_filter(staged_files)
        staged_files.grep(/\.rb$/)
      end

      def extra_grep
        " | grep -v \/\/"
      end

      def message
        "before(:all) found:"
      end

      def pattern
        '-e "before.*:all"'
      end

      def self.description
        "Find ruby files with 'before :all' pattern"
      end

    end
  end
end
