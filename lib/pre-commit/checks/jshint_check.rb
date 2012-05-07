require 'pre-commit/checks/js_check'
require 'multi_json'

class PreCommit
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

      js = []
      js << "JSHINT(#{MultiJson.dump(File.read(file))}, #{MultiJson.dump(config)});"
      js << "return JSHINT.errors;"

      context.exec js.join("\n")
    end

    def linter_src
      File.join(PreCommit.root, 'lib', 'support', 'jshint', 'jshint.js')
    end
  end
end
