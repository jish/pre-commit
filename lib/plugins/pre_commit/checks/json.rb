require 'json'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Json < Plugin
      def call(staged_files)
        staged_files = staged_files.grep(/\.json$/)
        return if staged_files.empty?

        errors = staged_files.map {|file| load_file(file)}.compact

        errors.join("\n") + "\n" unless errors.empty?
      end

      def load_file(file)
        File.open(file) {|io| JSON.load(io)}
        nil
      rescue JSON::ParserError => e
        "#{e.message} parsing #{file}"
      end

      def self.description
        'Runs json to detect errors.'
      end
    end
  end
end
