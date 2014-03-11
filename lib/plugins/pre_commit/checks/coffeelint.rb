require 'open3'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Coffeelint < Plugin

      def call(staged_files)
        staged_files = staged_files.grep(/\.coffee$/)
        return if staged_files.empty?

        args = (config_file_flag + staged_files).join(' ')

        stdout, stderr, result = Open3.capture3("coffeelint #{args}")
        stdout + stderr unless result.success?
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
