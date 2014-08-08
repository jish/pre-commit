require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class GoBuild < Plugin

      def call(staged_files)
        staged_files = staged_files.grep(/\.go$/)
        return if staged_files.empty?

        errors = staged_files.map { |file| run_check(file) }.compact
        return if errors.empty?

        errors.join("\n")
      end

      def run_check(file)
        cmd = "go build -o /dev/null #{file} 2>&1"
        %x[ #{cmd} ]
      end

      def self.description
        "Detects Go compiler errors"
      end
    end
  end
end
