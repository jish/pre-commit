require 'pre-commit/utils'
require 'pre-commit/checks/merge_conflict_check'
require 'pre-commit/checks/tabs_check'
require 'pre-commit/checks/console_log_check'
require 'pre-commit/checks/debugger_check'
require 'pre-commit/checks/local_check'
require 'pre-commit/checks/nb_space_check'
require 'pre-commit/checks/jslint_check'
require 'pre-commit/checks/jshint_check'
require 'pre-commit/checks/migration_check'
require 'pre-commit/checks/ci_check'
require 'pre-commit/checks/php_check'
require 'pre-commit/checks/pry_check'
require 'pre-commit/checks/rspec_focus_check'
require 'pre-commit/checks/ruby_symbol_hashrockets'
require 'pre-commit/checks/whitespace_check'
require 'pre-commit/checks/closure_check'
begin
  require 'pre-commit/checks/rubocop_check'
rescue LoadError # no rubocop
end

module PreCommit
  CHECKS = {
    :white_space             => WhiteSpaceCheck,
    :console_log             => ConsoleLogCheck,
    :js_lint_all             => JslintCheck.new(:all),
    :js_lint_new             => JslintCheck.new(:new),
    :jshint                  => JshintCheck.new,
    :debugger                => DebuggerCheck,
    :pry                     => PryCheck,
    :local                   => LocalCheck,
    :nb_space                => NbSpaceCheck,
    :tabs                    => TabsCheck,
    :closure_syntax_check    => ClosureCheck,
    :merge_conflict          => MergeConflictCheck,
    :migrations              => MigrationCheck,
    :ci                      => CiCheck.new,
    :php                     => PhpCheck.new,
    :rspec_focus             => RSpecFocusCheck,
    :ruby_symbol_hashrockets => RubySymbolHashrockets
  }

  CHECKS[:rubocop] = RubocopCheck if defined?(Rubocop)

  # Can not delete this method with out a deprecation strategy.
  # It is refered to in the generated pre-commit hook in versions 0.0-0.1.1
  #
  # NOTE: The deprecation strategy *may* be just delete it since, we're still
  # pre 1.0.

  #
  # Actually, on the deprecation note. This method isn't really the problem.
  # The problem is the default generated pre-commit hook. It shouldn't have
  # logic in it. The we have freedom to change the gem implementation however
  # we want, and nobody is forced to update their pre-commit binary.
  def self.checks_to_run
    checks_to_run = `git config pre-commit.checks`.chomp.split(/,\s*/).map(&:to_sym)

    if checks_to_run.empty?
      CHECKS.values_at(:white_space, :console_log, :debugger, :pry, :tabs, :jshint,
        :migrations, :merge_conflict, :local, :nb_space)
    else
      if checks_to_run.delete(:rubocop_all) || checks_to_run.delete(:rubocop_all)
        $stderr.puts "please use just 'rubocop' as check name"
        checks_to_run << :rubocop
      end

      CHECKS.values_at(*checks_to_run)
    end.compact
  end

  def self.run
    exit_status = self.checks_to_run.inject(true) do |acc, cmd|
      cmd.call && acc
    end

    exit(exit_status ? 0 : 1)
  end
end
