require 'pre-commit/checks/js'

module PreCommit
  module Checks
    class Jshint < Js

      def run_check(file)
        context.call("JSHINT._getErrors", File.read(file), js_config, js_config["globals"])
      end

      def linter_src
        File.expand_path("../../../../pre-commit/support/jshint/jshint.js", __FILE__)
      end

      def alternate_config_file
        ".jshintrc"
      end

      def self.description
        "Checks javascript files with JSHint."
      end

      private

      def context
        @context ||= ExecJS.compile("global = this;" << File.read(linter_src) << <<-JAVASCRIPT)
          ;JSHINT._getErrors = function(source, options, globals) {
            JSHINT(source, options, globals);
            return JSHINT.errors;
          }
        JAVASCRIPT
      end

      def js_config
        @js_config ||= if config_file
          ExecJS.exec("return (#{File.read(config_file)});")
        else
          {}
        end
      end

    end
  end
end
