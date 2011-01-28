require 'support/all'
require 'pre-commit/utils'
require 'pre-commit/checks/merge_conflict'
require 'pre-commit/checks/tabs'
require 'pre-commit/checks/console_log'
require 'pre-commit/checks/debugger_check'

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

    if errors.empty?
      true
    else
      puts errors.join("\n")
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
    :js_lint_all          => JSLintAll,
    :js_lint_new          => JSLintNew,
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
  def self.checks_to_run
    checks_to_run = `git config pre-commit.checks`.chomp.split(/,\s*/).map(&:to_sym)

    if checks_to_run.empty?
      Checks.values_at(:white_space, :console_log, :debugger, :tabs, :closure_syntax_check, :js_lint_new)
    else
      Checks.values_at(*checks_to_run)
    end.compact
  end
end
