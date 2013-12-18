require 'pre-commit/utils'
require 'stringio'

module PreCommit::Checks

  class Rubocop
    def self.supports(name)
      [ :rubocop_all, :rubocop_new ].include?(name)
    end
    def self.call(staged_files)
      require 'rubocop'
    rescue LoadError => e
      $stderr.puts "Could not find rubocop: #{e}"
    else
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
  end
end