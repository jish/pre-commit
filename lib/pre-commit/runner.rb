require 'pluginator'
require 'pre-commit/utils'
require 'pre-commit/configuration'

module PreCommit
  class Runner

    attr_reader :pluginator, :config, :staged_files

    def initialize(staged_files = nil, config = nil, pluginator = nil, stderr = nil)
      @staged_files = staged_files || Utils.staged_files
      @config       = config       || PreCommit::Configuration.new(pluginator)
      @pluginator   = pluginator   || Pluginator.find('pre_commit', :extends => [:find_check] )
      @stderr       = stderr       || $stderr
    end

    def run
      show_output(:warnings, execute(list_to_run(:warnings)))
      show_output(:checks,   execute(list_to_run(:checks  ))){ false }
    end

    def show_output(name, list)
      if list.any?
        @stderr.puts send(name, list)
        yield if block_given?
      end
    end

    def execute(list)
      list.map{|cmd| cmd.call(staged_files.dup) }.compact
    end

    def list_to_run(name)
      config.get_combined(name).map{|name| pluginator.find_check(name) }.compact
    end

    def warnings(list)
      <<-WARNINGS
pre-commit: Some warnings were raised. These will not stop commit:
#{list.join("\n")}
WARNINGS
    end

    def checks(list)
      <<-ERRORS
pre-commit: Stopping commit because of errors.
#{list.join("\n")}

pre-commit: You can bypass this check using `git commit -n`

ERRORS
    end

  end
end
