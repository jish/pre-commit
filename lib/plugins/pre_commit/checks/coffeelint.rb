require 'pre-commit/checks/shell'

module PreCommit
  module Checks
    class Coffeelint < Shell

      def call(staged_files)
        staged_files = staged_files.grep(/\.coffee$/)
        return if staged_files.empty?

        args = %w{coffeelint} + config_file_flag + staged_files

        execute(args)
      end

      def config_file_flag
        config_file ? ['-f', config_file] : []
      end

      def alternate_config_file
        'coffeelint.json'
      end

      def self.description
        "Runs coffeelint to detect errors"
      end

    end
  end
end
