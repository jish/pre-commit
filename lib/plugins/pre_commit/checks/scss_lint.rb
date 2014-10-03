require 'pre-commit/checks/shell'

module PreCommit
  module Checks
    class ScssLint < Shell

      def call(staged_files)
        staged_files = staged_files.grep(/\.scss$/)
        return if staged_files.empty?

        result =
        in_groups(staged_files).map do |files|
          args = %w{scss-lint} + config_file_flag + files
          execute(args)
        end.compact

        result.empty? ? nil : result.join("\n")
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
