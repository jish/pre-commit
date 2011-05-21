require 'pre-commit/checks/js_check'

class PreCommit
  class JshintCheck < JsCheck

    def check_name
      "JSHint"
    end

    def files_to_check
      Utils.staged_files('.').split(" ")
    end

    def run_check(file)
      context = ExecJS.compile(File.read(linter_src))
      if !(context.call('JSHINT', File.read(file)))
        context.exec('return JSHINT.errors;')
      else
        []
      end
    end

    def linter_src
      File.join(PreCommit.root, 'lib', 'support', 'jshint', 'jshint.js')
    end
  end
end
