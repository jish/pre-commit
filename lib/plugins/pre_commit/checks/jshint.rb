require 'plugins/pre_commit/checks/js'

module PreCommit
  module Checks
    class Jshint < Js
      def self.config
        if config_file = [ENV['JSHINT_CONFIG'], ".jshintrc"].compact.detect { |f| File.exist?(f) }
          ExecJS.exec("return (#{File.read(config_file)});")
        else
          {}
        end
      end

      def self.run_check(file)
        context = ExecJS.compile(File.read(linter_src))
        context.call("JSHINT", File.read(file), config, config["globals"])
      end

      def self.linter_src
        File.expand_path("../../../../pre-commit/support/jshint/jshint.js", __FILE__)
      end
    end
  end
end
