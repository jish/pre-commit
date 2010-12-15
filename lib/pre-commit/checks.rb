require 'support/all'
require 'pre-commit/utils'

class PreCommit

  WhiteSpace = lambda { 
    WhiteSpaceChecker.check
  }

  ConsoleLog = lambda {
    
    if File.exists?('public/javascripts') && (args = Utils.staged_files('public/javascripts')).size > 0
      if system("git grep -n -q \"console\.log\" #{args}")
        puts "\n[ERROR] console.log found:"
        !system("git grep -n \"console\.log\" #{args}")
      else
        true
      end
    else
      true
    end
  }

  Debugger = lambda {
    dirs = ['app/', 'lib/', 'script/', 'vendor/', 'test/'].reject {|d| !File.exists?(d)}
    if dirs.size > 0 && (args = Utils.staged_files(dirs)).size > 0
      if system("git grep -n -q debugger #{args}") 
        puts "\n[ERROR] debugger statement(s) found:"
        !system("git grep -n debugger #{args}") 
      else
        true
      end
    else
      true
    end
  }

  Tabs = lambda {
    if (files = Utils.staged_files('*')).size > 0
      if system("grep -PnH -q '^\t' #{files}")
        puts "\n[ERROR] tab before initial space:"
        !system("grep -PnH '^\t' #{files}")
      else
        true
      end
    else
      true
    end
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
    :debugger             => Debugger,
    :tabs                 => Tabs,
    :closure_syntax_check => ClosureSyntaxCheck
  }

  def self.checks_to_run
    checks_to_run = `git config pre-commit.checks`.chomp.split(/,\s*/).map(&:to_sym)

    if checks_to_run.empty?
      Checks.values_at(:white_space, :console_log, :debugger, :tabs, :closure_syntax_check, :js_lint_new)
    else
      Checks.values_at(*checks_to_run)
    end.compact
  end
end
