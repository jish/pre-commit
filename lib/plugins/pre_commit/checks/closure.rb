require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Closure < Plugin
      def self.aliases
        [:closure_syntax_check]
      end

      def call(staged_files)
        return if staged_files.empty?
        js_args = staged_files.map {|arg| "--js #{arg}"}.join(' ')
        errors = `java -jar #{support_path('compiler.jar')} #{js_args} --js_output_file /tmp/jammit.js 2>&1`.strip
        return if errors.empty?
        errors
      end

      def self.description
        "Runs closure compiler to detect errors"
      end

    end
  end
end
