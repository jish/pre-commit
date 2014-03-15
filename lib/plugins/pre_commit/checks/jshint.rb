require 'pre-commit/checks/js'

module PreCommit
  module Checks
    class Jshint < Js

      def js_config
        if config_file
          ExecJS.exec("return (#{File.read(config_file)});")
        else
          {}
        end
      end

      def run_check(file)
        context = ExecJS.compile(File.read(linter_src))
        context.call("JSHINT", File.read(file), js_config, js_config["globals"])
      end

      def linter_src
        support_path("jshint.js")
      end

      def alternate_config_file
        ".jshintrc"
      end

      def self.description
        "Checks javascript files with JSHint."
      end

    end
  end
end
