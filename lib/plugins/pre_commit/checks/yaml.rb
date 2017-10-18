# frozen-string-literal: true

require 'yaml'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    ##
    # The Yaml check will read and parse YAML files to ensure they have valid
    # syntax.
    #
    class Yaml < Plugin
      def self.description
        'Runs yaml to detect errors.'
      end

      def call(staged_files)
        staged_files = staged_files.grep(/\.(yml|yaml)$/)
        return if staged_files.empty?

        errors = staged_files.map {|file| load_file(file)}.compact

        errors.join("\n") + "\n" unless errors.empty?
      end

      private

      def load_file(file)
        if YAML.respond_to?(:safe_load)
          safe_load_file(file)
        else
          normal_load_file(file)
        end

      rescue Psych::SyntaxError => e
        e.message
      end

      def safe_load_file(file)
        YAML.safe_load(File.read(file), [::Symbol], [], true, file)

        nil
      rescue Psych::DisallowedClass
        $stdout.puts "Warning: Skipping '#{file}' because it contains serialized ruby objects."
      end

      def normal_load_file(file)
        YAML.load_file(file)

        nil
      rescue ArgumentError
        $stdout.puts "Warning: Skipping '#{file}' because it contains serialized ruby objects."
      end
    end
  end
end
