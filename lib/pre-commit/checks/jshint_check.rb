require 'pre-commit/checks/js_check'

module PreCommit
  class JshintCheck < JsCheck
    def self.config
      if config_file = [ENV['JSHINT_CONFIG'], ".jshintrc"].compact.detect { |f| File.exist?(f) }
        ExecJS.exec("return (#{File.read(config_file)});")
      else
        {}
      end
    end

    def self.check_name
      "JSHint"
    end

    def self.run_check(file)
      context = ExecJS.compile(File.read(linter_src))
      context.call('JSHINT', File.read(file), config)
    end

    def self.linter_src
      File.expand_path("../../support/jshint/jshint.js", __FILE__)
    end
  end
end
