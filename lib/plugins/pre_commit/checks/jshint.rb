require 'pre-commit/checks/js'

module PreCommit
  module Checks
    class Jshint < Js
      def config
        if config_file = [ENV['JSHINT_CONFIG'], ".jshintrc"].compact.detect { |f| File.exist?(f) }
          ExecJS.exec("return (#{File.read(config_file)});")
        else
          {}
        end
      end

      def check_name
        "JSHint"
      end

      def run_check(file)
        context = ExecJS.compile(File.read(linter_src))
        context.call('JSHINT', File.read(file), config)
      end

      def linter_src
        File.expand_path("../../../../pre-commit/support/jshint/jshint.js", __FILE__)
      end
    end
  end
end
