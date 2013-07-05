require 'pre-commit/checks/js_check'

module PreCommit
  class JslintCheck < JsCheck

    attr_accessor :type

    def check_name
      "JSLint"
    end

    def initialize(type = :all)
      @type = type
    end

    def files_to_check
      case @type
      when :new
        Utils.new_files('.').split(" ")
      else
        Utils.staged_files('.').split(" ")
      end
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
      File.expand_path("../../support/jslint/lint.js", __FILE__)
    end

  end
end
