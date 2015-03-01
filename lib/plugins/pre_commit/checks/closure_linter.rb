require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class ClosureLinter < Plugin
      def call(staged_files)
        staged_files = staged_files.grep(/\.js$/)
        return if staged_files.empty?

        output = `gjslint --nojsdoc #{staged_files.join(" ")}`
        return if output =~ /(\d*) files checked, no errors found(.*)/

        output
      end

      def self.description
        "Runs closure linter syntax check"
      end

    end
  end
end
