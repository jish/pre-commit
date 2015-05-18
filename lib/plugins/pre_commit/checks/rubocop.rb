require 'stringio'
require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Rubocop < Plugin

      def self.aliases
        [ :rubocop_all, :rubocop_new ]
      end

      def self.excludes
        [ :ruby_symbol_hashrocket ]
      end

      def call(staged_files)
        require 'rubocop'
      rescue LoadError => e
        $stderr.puts "Could not find rubocop: #{e}"
      else
        allowed_files_regex = /\.gemspec\Z|
                               \.podspec\Z|
                               \.jbuilder\Z|
                               \.rake\Z|
                               \.opal\Z|
                               \.rb\Z|
                               config\.ru\Z|
                               Gemfile\Z|
                               Rakefile\Z|
                               Capfile\Z|
                               Guardfile\Z|
                               Podfile\Z|
                               Thorfile\Z|
                               Vagrantfile\Z|
                               Berksfile\Z|
                               Cheffile\Z|
                               Vagabondfile\Z
                              /x
        staged_files = staged_files.grep(allowed_files_regex)
        return if staged_files.empty?

        args = config_file_flag + user_supplied_flags + ["--force-exclusion"] + staged_files

        success, captured = capture { ::RuboCop::CLI.new.run(args) == 0 }
        captured unless success
      end

      def capture
        $stdout, stdout = StringIO.new, $stdout
        $stderr, stderr = StringIO.new, $stderr
        result = yield
        [result, $stdout.string + $stderr.string]
      ensure
        $stdout = stdout
        $stderr = stderr
      end

      def config_file_flag
        config_file ? ['-c', config_file] : []
      end

      def user_supplied_flags
        Array(config.get('rubocop.flags')).reject(&:empty?)
      end

      def alternate_config_file
        '.rubocop.yml'
      end

      def self.description
        "Runs rubocop to detect errors."
      end
    end
  end
end
