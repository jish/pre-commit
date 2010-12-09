#!/usr/bin/env ruby



class Utils

  def self.staged_files(*dirs)
    @staged_files ||= {}
    @staged_files[dirs.join(' ')] ||= `git diff --cached --name-only #{dirs.join(' ')} | xargs`.chomp
  end


end

class PreCommit

  WhiteSpace = lambda { system("sh ./.git/hooks/whitespace") }

  ConsoleLog = lambda {
    if (args = Utils.staged_files('public/javascripts')).size > 0
      !system("git grep -n \"console\.log\" #{args}")
    else
      true
    end
  }

  Debugger = lambda {
    if (args = Utils.staged_files('app/', 'lib/', 'script/', 'vendor/', 'test/')).size > 0
      !system("git grep debugger #{args}")
    else
      true
    end
  }

  Tabs = lambda {
    if (files = Utils.staged_files('*')).size > 0
      !system("grep -PnH '^\t' #{files}")
    else
      true
    end
  }

  ClosureSyntaxCheck = lambda {
    compiler = "test/javascript/lib/compiler.jar"

    if (args = Utils.staged_files('public/javascripts')).size > 0
      js_args = args.map {|arg| "--js #{arg}"}.join(' ')
      system("java -jar test/javascript/lib/compiler.jar #{js_args} --js_output_file /tmp/jammit.js")
    else
      true
    end
  }

  Checks = {
    :white_space          => WhiteSpace,
    :console_log          => ConsoleLog,
    :debugger             => Debugger,
    :tabs                 => Tabs,
    :closure_syntax_check => ClosureSyntaxCheck
  }

  def self.checks_to_run
    checks_to_run = `git config pre-commit.checks`.chomp.split(/,\s*/).map(&:to_sym)

    if checks_to_run.empty?
      Checks.values_at(:white_space, :console_log, :debugger, :tabs, :closure_syntax_check)
    else
      Checks.values_at(*checks_to_run)
    end.compact
  end
end

exit_status = PreCommit.checks_to_run.inject(true) do |acc, cmd|
  acc = cmd.call && acc
end

exit(exit_status ? 0 : 1)
