require 'fileutils'
require 'pre-commit/configuration'
require 'pre-commit/installer'

module PreCommit

  TemplateNotFound = Class.new(StandardError)

  class Cli

    TEMPLATE_DIR = File.expand_path("../support/templates/", __FILE__)

    def initialize(*args)
      @args = args
    end

    def execute()
      action_name = @args.shift or 'help'
      action = "execute_#{action_name}".to_sym
      if respond_to?(action)
      then send(action, *@args)
      else execute_help(action_name, *@args)
      end
    end

    def execute_help(*args)
      warn "Unknown parameters: #{args * " "}" unless args.empty?
      warn "Usage: pre-commit install"
      warn "Usage: pre-commit list"
      warn "Usage: pre-commit <enable|disbale> <git|yaml> <checks|warnings> check1 [check2]"
      args.empty? # return status, it's ok if user requested help
    end

    def execute_install(key = nil, *args)
      PreCommit::Installer.new(key).install
    end

    def execute_list(*args)
      puts config.list
      true
    end

    def execute_enable(*args)
      config.enable(*args)
      #rescue ArgumentsError
      #execute_help('enable', *args)
    end

    def execute_disable(*args)
      config.disable(*args)
      #rescue ArgumentsError
      #execute_help('disable', *args)
    end

  private

    def config
      @config ||= PreCommit::Configuration.new(Pluginator.find('pre_commit'))
    end

  end
end
