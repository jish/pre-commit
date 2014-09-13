require 'pluginator'
require 'benchmark'

require 'pre-commit/utils/staged_files'
require 'pre-commit/configuration'
require 'pre-commit/list_evaluator'
require 'pre-commit/error_list'

module PreCommit
  class Runner
    include PreCommit::Utils::StagedFiles

    attr_reader :pluginator, :config, :debug

    def initialize(stderr = nil, staged_files = nil, config = nil, pluginator = nil)
      @stderr       = (stderr       or $stderr)
      @pluginator   = (pluginator   or PreCommit.pluginator)
      @config       = (config       or PreCommit::Configuration.new(@pluginator))
      @staged_files = staged_files
      @debug = ENV["PRE_COMMIT_DEBUG"]
    end

    def run(*args)
      set_staged_files(*args)
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
      list.map do |cmd|
        result = nil

        seconds = Benchmark.realtime do
          result = cmd.new(pluginator, config, list).call(staged_files.dup)
        end

        puts "#{cmd} #{seconds*1000}ms" if debug

        result
      end.compact
    end

    def list_to_run(name)
      list_evaluator.send(:"#{name}_evaluated", :list_to_run)
    end

    def list_evaluator
      @list_evaluator ||= PreCommit::ListEvaluator.new(config)
    end

    def warnings(list)
      <<-WARNINGS
pre-commit: Some warnings were raised. These will not stop commit:
#{errors_to_string(list)}
WARNINGS
    end

    def checks(list)
      <<-ERRORS
pre-commit: Stopping commit because of errors.
#{errors_to_string(list)}
pre-commit: You can bypass this check using `git commit -n`

ERRORS
    end

    def errors_to_string(list)
      list.map(&:to_s).join("\n")
    end

  end
end
