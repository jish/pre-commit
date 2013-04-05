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
      args = rb_files
      if !config_file.empty?
        if !File.exist? config_file
          $stderr.puts "Warning: rubocop config file '" + config_file + "' does not exist"
          $stderr.puts "Set the path to the config file using:"
          $stderr.puts "\tgit config pre-commit.rubocop.config 'path/relative/to/git/dir/rubocop.yml'"
          $stderr.puts "rubocop will use its default configuration or look for a .rubocop.yml file\n\n"
        else
          args = ['-c', config_file] + args
        end
      end
      run(args)
    end

    def run(rb_files)
      rubocop = Rubocop::CLI.new
      return rubocop.run(rb_files) == 0
    end

  end
end
