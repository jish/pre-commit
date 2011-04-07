# This (PreCommit) should be a module
# ... it should also have a cooler name :P
class PreCommit
  class JslintCheck

    attr_accessor :therubyracer_installed, :type

    def initialize(type = :all)
      @type = type
      @therubyracer_installed = check_for_therubyracer_install
    end

    def should_run?
      @therubyracer_installed
    end

    def call
      if should_run?
        run
      else
        $stderr.puts 'pre-commit: Skipping JSLint check (to run it: `gem install therubyracer`)'
        # pretent the check passed and move on
        true
      end
    end

    def run
      errors = check_to_run.call
    end

    def check_to_run
      @type == :all ? JSLintAll : JSLintNew
    end

    private

    def check_for_therubyracer_install
      require 'v8'
      @therubyracer_installed = true
    rescue LoadError
      @therubyracer_installed = false
    end

  end
end
