require 'pre-commit/checks/js'

module PreCommit
  module Checks
    class Jshint < Js

      def js_config
        @js_config ||= if config_file
          ExecJS.exec("return (#{File.read(config_file)});")
        else
          {}
        end
      end

      def run_check(file)
        context = get_context
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

      def get_context
        return @context if defined?(@context)

        get_errors = <<-JAVASCRIPT
          JSHINT._getErrors = function(source, options, globals) {
            JSHINT(source, options, globals);
            return JSHINT.errors;
          }
        JAVASCRIPT

        @context = ExecJS.compile(File.read(linter_src) + get_errors)
      end

    end
  end
end
