require 'pluginator'
require 'pre-commit/utils'
require 'pre-commit/configuration'

module PreCommit
  class Runner

    attr_reader :pluginator, :config, :staged_files

    def initialize(stderr = nil, staged_files = nil, config = nil, pluginator = nil)
      @stderr       = (stderr       or $stderr)
      @pluginator   = (pluginator   or Pluginator.find('pre_commit', :extends => [:find_check] ))
      @config       = (config       or PreCommit::Configuration.new(@pluginator))
      @staged_files = (staged_files or Utils.staged_files)
    end

    def run
      run_single(:warnings)
      run_single(:checks  ) or return false
      true
    end

    def run_single(name)
      show_output(name, execute(list_to_run(name)))
    end

    def show_output(name, list)
      if list.any?
        @stderr.puts send(name, list)
        return false
      end
      true
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
