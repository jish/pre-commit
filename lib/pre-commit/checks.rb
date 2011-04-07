require 'support/all'
require 'pre-commit/utils'
require 'pre-commit/checks/merge_conflict'
require 'pre-commit/checks/tabs'
require 'pre-commit/checks/console_log'
require 'pre-commit/checks/debugger_check'
require 'pre-commit/checks/jslint_check'

class PreCommit

  WhiteSpace = lambda { 
    WhiteSpaceChecker.check
  }

  ClosureSyntaxCheck = lambda {
    compiler = "test/javascript/lib/compiler.jar"

    if File.exists?('public/javascripts') && (args = Utils.staged_files('public/javascripts')).size > 0
      ClosureChecker.check(args.split(" "))
    else
      true
    end
  }

  JSLintCheck = lambda { |files|
    errors = []
    files.each do |file|
      errors << JSLint.lint_file(file)
    end

    # JSLint.lint_file returns an array.
    # Therefore no errors looks like this: [[]]
    # And errors.empty? returns false
    errors.flatten!

    if errors.empty?
      true
    else
      $stderr.puts errors.join("\n")
      $stderr.puts
      $stderr.puts 'pre-commit: You can bypass this check using `git commit -n`'
      $stderr.puts
      false
    end
  }

  JSLintNew = lambda {
    new_js_files = Utils.new_files('.').split(" ").reject {|f| f !~ /\.js$/}
    JSLintCheck[new_js_files]
  }

  JSLintAll = lambda {
    staged_js_files = Utils.staged_files('.').split(" ").reject {|f| f !~ /\.js$/}
    JSLintCheck[staged_js_files]
  }
  
  Checks = {
    :white_space          => WhiteSpace,
    :console_log          => ConsoleLog,
    :js_lint_all          => JslintCheck.new(:all),
    :js_lint_new          => JslintCheck.new(:new),
    :debugger             => DebuggerCheck,
    :tabs                 => Tabs,
    :closure_syntax_check => ClosureSyntaxCheck,
    :merge_conflict       => MergeConflict
  }

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
      Checks.values_at(:white_space, :console_log, :debugger, :tabs, :js_lint_new)
    else
      Checks.values_at(*checks_to_run)
    end.compact
  end
end
