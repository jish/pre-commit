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

      def error_selector
        'message'
      end

      def files_filter(staged_files)
        staged_files.grep(/\.css$/)
      end

      def self.description
        "Checks CSS files with CSSLint."
      end

    end
  end
end
