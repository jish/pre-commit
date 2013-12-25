require 'fileutils'
require 'pre-commit/configuration'

module PreCommit

  TemplateNotFound = Class.new(StandardError)

  class Cli

    PRE_COMMIT_HOOK_PATH = '.git/hooks/pre-commit'
    TEMPLATE_DIR = File.expand_path("../support/templates/", __FILE__)

    def initialize(*args)
      @args = args
    end

    def execute()
      action = @args.shift or 'help'
      action = "execute_#{action}".to_sym
      if respond_to?(action)
      then send(action, *@args)
      else execute_help(action, *@args)
      end
    end

    def execute_help(*args)
      warn "Unknown parameters: #{args * " "}" unless args.empty?
      warn "Usage: pre-commit [install|show]"
      args.empty? # return status, it's ok if user requested help
    end

    def execute_install(key = nil, *args)
      key ||= "default"
      hook = templates[key.sub(/^--/, "")]

      raise TemplateNotFound.new("Could not find template #{key}") unless hook

      FileUtils.cp(hook, PRE_COMMIT_HOOK_PATH)
      FileUtils.chmod(0755, PRE_COMMIT_HOOK_PATH)
    rescue PreCommit::TemplateNotFound => e
      warn e.message
      false
    else
      puts "Installed #{hook} to #{PreCommit::Cli::PRE_COMMIT_HOOK_PATH}"
      true
    end

    def execute_show(*args)
      puts "Default checks: #{config.get_arr(:checks).join(" ")}"
      puts "Enabled checks: #{config.get_combined(:checks).join(" ")}"
      puts "Default warnings: #{config.get_arr(:warnings).join(" ")}"
      puts "Enabled warnings: #{config.get_combined(:warnings).join(" ")}"
      true
    end

  private

    def config
      @config ||= PreCommit::Configuration.new(Pluginator.find('pre_commit'))
    end

    def templates
      return @templates if @templates
      pattern = File.join(TEMPLATE_DIR, "*_hook")

      @templates =
      Dir.glob(pattern).inject({}) do |hash, file|
        key = file.match(/\/([^\/]+?)_hook$/)[1]
        hash[key] = file
        hash
      end
    end

  end
end
