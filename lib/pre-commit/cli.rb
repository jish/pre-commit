require 'fileutils'
require 'pre-commit/configuration'
require 'pre-commit/installer'
require 'pre-commit/list_evaluator'
require 'pre-commit/template'

module PreCommit

  TemplateNotFound = Class.new(StandardError)

  class Cli

    def initialize(*args)
      @args = args
    end

    def execute()
      action_name = @args.shift or 'help'
      action = :"execute_#{action_name}"
      if respond_to?(action)
      then send(action, *@args)
      else execute_help(action_name, *@args)
      end
    end

    def execute_help(*args)
      warn "Unknown parameters: #{args.map(&:inspect) * " "}" unless args.empty?
      warn "Usage: pre-commit install"
      warn "Usage: pre-commit list"
      warn "Usage: pre-commit plugins"
      warn "Usage: pre-commit new plugin-name 'Author Name' author@email 'description of the plugin'"
      warn "Usage: pre-commit <enable|disable> <git|yaml> <checks|warnings> check1 [check2...]"
      args.empty? # return status, it's ok if user requested help
    end

    def execute_run(*args)
      require 'pre-commit/runner'
      PreCommit::Runner.new.run(*args).tap { |ok| puts "No failed checks." if ok }
    end

    def execute_install(key = nil, *args)
      PreCommit::Installer.new(key).install
    end

    def execute_list(*args)
      puts list_evaluator.list
      true
    end

    def execute_plugins(*args)
      puts list_evaluator.plugins
      true
    end

    def execute_new(*args)
      PreCommit::Template.new(*args).save
    rescue ArgumentError => e
      warn e
      warn "Usage: pre-commit new plugin-name 'Author Name' author@email 'description of the plugin'"
    end

    def execute_enable(*args)
      config.enable(*args)
    rescue ArgumentError
      execute_help('enable', *args)
    end

    def execute_disable(*args)
      config.disable(*args)
    rescue ArgumentError
      execute_help('disable', *args)
    end

    def config
      @config ||= PreCommit::Configuration.new(PreCommit.pluginator)
    end

    def list_evaluator
      @list_evaluator ||= PreCommit::ListEvaluator.new(config)
    end

  end
end
