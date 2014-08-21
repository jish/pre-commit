# encoding: utf-8

require 'pre-commit/checks/shell'

# Plugins for pre-commit
module PreCommit
  # Checking plugins for pre-commit
  module Checks
    # Runs reek to detect ruby code smells
    class Reek < Shell
      def call(staged_files)
        staged_files = staged_files.grep(/\.rb/)
        return if staged_files.empty?

        args = (config_file_flag + staged_files).join(' ')

        execute("reek #{args}")
      end

      def config_file_flag
        config_file ? ['-c', config_file] : []
      end

      def alternate_config_file
        'config/.reek'
      end

      def self.description
        "Runs reek to detect ruby code smells"
      end
    end
  end
end
