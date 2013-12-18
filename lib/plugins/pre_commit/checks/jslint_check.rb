require 'plugins/pre_commit/checks/js_check'

module PreCommit::Checks
  class JslintCheck < JsCheck
    def self.supports(name)
      [ :js_lint, :js_lint_all, :js_lint_new ].include?(name)
    end

    def self.run_check(file)
      context = ExecJS.compile(File.read(linter_src))
      if !(context.call('JSLINT', File.read(file)))
        context.exec('return JSLINT.errors;')
      else
        []
      end
    end

    def self.linter_src
      File.expand_path("../../../../pre-commit/support/jslint/lint.js", __FILE__)
    end
  end
end
