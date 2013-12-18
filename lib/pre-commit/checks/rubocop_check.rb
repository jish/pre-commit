require 'pre-commit/utils'
require 'stringio'

module PreCommit
  begin
    require 'rubocop'
    rubocop_loaded = true
  rescue LoadError # no rubocop
  end

  class RubocopCheck
    def self.call(staged_files)
      staged_files = staged_files.grep(/\.rb$/)
      return if staged_files.empty?
      config_file = `git config pre-commit.rubocop.config`.chomp

      args = staged_files
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

      success, captured = capture { Rubocop::CLI.new.run(args) == 0 }
      captured unless success
    end

    def self.capture
      $stdout, stdout = StringIO.new, $stdout
      $stderr, stderr = StringIO.new, $stderr
      result = yield
      [result, $stdout.string + $stderr.string]
    ensure
      $stdout = stdout
      $stderr = stderr
    end
  end if rubocop_loaded
end
