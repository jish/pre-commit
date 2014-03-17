require 'open3'
require 'pre-commit/checks/shell'

module PreCommit
  module Checks
    class Checkstyle < Shell
      def call(staged_files)
        staged_files = staged_files.grep(/\.java$/)
        return if staged_files.empty?

        args = (jar_flag + config_file_flag + staged_files).join(' ')

        execute("java #{args}")
      end

      def jar_flag
        ['-jar', support_path('checkstyle-5.7-all.jar')]
      end

      def config_file_flag
        config_file ? ['-c', config_file] : []
      end

      def alternate_config_file
        support_path('sun_checks.xml')
      end

      def self.description
        'Runs coffeelint to detect errors'
      end
    end
  end
end
