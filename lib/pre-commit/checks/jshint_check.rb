require 'pre-commit/checks/js_check'

module PreCommit
  class JshintCheck < JsCheck

    def check_name
      "JSHint"
    end

    def files_to_check
      Utils.staged_files('.').split(" ")
    end

    def config
      config_file = ENV['JSHINT_CONFIG']
      config_file ||= File.exists?(".jshintrc") ? ".jshintrc" : nil

      if config_file
        ExecJS.exec("return (#{File.read(config_file)});")
      else
        {}
      end
    end

    def run_check(file)
      context = ExecJS.compile(File.read(linter_src))
      context.call('JSHINT', File.read(file), config)
    end

    def linter_src
      File.expand_path("../../support/jshint/jshint.js", __FILE__)
    end

  end
end
