require 'pre-commit/checks/js'

module PreCommit
  module Checks
    class Jslint < Js

      def self.aliases
        [ :js_lint, :js_lint_all, :js_lint_new ]
      end

      def run_check(file)
        context = ExecJS.compile(File.read(linter_src))
        if !(context.call('JSLINT', File.read(file)))
          context.exec('return JSLINT.errors;')
        else
          []
        end
      end

      def linter_src
        File.expand_path("../../../../pre-commit/support/jslint/lint.js", __FILE__)
      end

      def self.description
        "Checks javascript files with JSLint."
      end

    end
  end
end
