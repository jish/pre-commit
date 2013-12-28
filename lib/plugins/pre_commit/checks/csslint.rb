require 'pre-commit/checks/js'

module PreCommit
  module Checks
    class Csslint < Js

      SOURCE = "https://github.com/stubbornella/csslint/blob/v0.10.0/release/csslint.js"

      def run_check(file)
        context = ExecJS.compile(File.read(linter_src))
        context.call("CSSLint.verify", File.read(file))["messages"]
      end

      def linter_src
        File.expand_path("../../../../pre-commit/support/csslint/csslint.js", __FILE__)
      end

      def display_error(error_object, file)
        return "" unless error_object

        line = error_object['line'].to_i + 1
        "#{error_object['message']}\n#{file}:#{line} #{error_object['evidence']}"
      end

      def files_filter(staged_files)
        staged_files.grep(/\.css$/)
      end

      def self.description
        "Checks CSS files with CSSHint."
      end

    end
  end
end
