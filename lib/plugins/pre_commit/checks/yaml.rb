require 'yaml'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Yaml < Plugin
      def call(staged_files)
        staged_files = staged_files.grep(/\.(yml|yaml)$/)
        return if staged_files.empty?

        errors = staged_files.map {|file| load_file(file)}.compact

        errors.join("\n") + "\n" unless errors.empty?
      end

      def load_file(file)
        YAML.load_file(file)
        nil
      rescue Psych::SyntaxError => e
        e.message
      end

      def self.description
        'Runs yaml to detect errors.'
      end
    end
  end
end
