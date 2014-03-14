require 'open3'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Checkstyle < Plugin
      def call(staged_files)
        staged_files = staged_files.grep(/\.java$/)
        return if staged_files.empty?

        args = (jar_flag + config_file_flag + checks_file_flag + staged_files).join(' ')

        stdout, stderr, result = Open3.capture3("java #{args}")
        stdout + stderr unless result.success?
      end

      def jar_flag
        ['-jar', support_path('checkstyle-5.7-all.jar')]
      end

      def config_file_flag
        config_file ? ['-p', config_file] : []
      end

      def checks_file_flag
        checks_file ? ['-c', checks_file] : []
      end

      def checks_file
        @checks_file ||= ConfigFile.new(name, config, support_path('sun_checks.xml'), 'checks')
        @checks_file.location
      end

      def self.description
        'Runs coffeelint to detect errors'
      end
    end
  end
end
