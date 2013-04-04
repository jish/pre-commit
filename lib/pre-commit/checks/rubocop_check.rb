require 'pre-commit/base'
require 'pre-commit/utils'
require 'rubocop'

module PreCommit
  class RubocopCheck

    attr_accessor :type

    def check_name
      "Rubocop"
    end

    def initialize(type = :all)
      @type = type
    end

    def files_to_check
      case @type
      when :new
        Utils.new_files('.').split(" ")
      else
        Utils.staged_files('.').split(" ")
      end
    end

    def reject_non_rb(staged_files)
      staged_files.select { |f| f =~ /\.e?rb$/ }
    end

    def call
      rb_files = reject_non_rb(files_to_check)
      return true if rb_files.empty?
      config_file = `git config pre-commit.rubocop.config`.chomp
      puts `pwd`
      if !config_file.empty?
        args = ['-c', config_file] + rb_files
      else
        args = rb_files
      end
      run(args)
    end

    def run(rb_files)
      rubocop = Rubocop::CLI.new
      return rubocop.run(rb_files) == 0
    end

  end
end
