require 'pre-commit/checks/js_check'

module PreCommit
  class JslintCheck < JsCheck
    def self.check_name
      "JSLint"
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
      File.expand_path("../../support/jslint/lint.js", __FILE__)
    end
  end
end
