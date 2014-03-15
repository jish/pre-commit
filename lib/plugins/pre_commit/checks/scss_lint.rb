require 'pre-commit/checks/shell'

module PreCommit
  module Checks
    class ScssLint < Shell

      def call(staged_files)
        staged_files = staged_files.grep(/\.scss$/)
        return if staged_files.empty?

        args = (config_file_flag + staged_files).join(' ')

        execute("scss-lint #{args}")
      end

      def config_file_flag
        config_file ? ['-c', config_file] : []
      end

      def alternate_config_file
        '.scss-lint.yml'
      end

      def self.description
        "Runs scss lint to detect errors"
      end

    end
  end
end
