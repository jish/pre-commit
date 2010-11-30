#!/usr/bin/env ruby



class Utils
  def self.staged_files(*dirs)
    @staged_files ||= {}
    @staged_files[dirs.join(' ')] ||= `git diff --cached --name-only #{dirs.join(' ')} | xargs`.chomp
  end
end

WhiteSpace = lambda { system("sh ./.git/hooks/whitespace") }

ConsoleLog = lambda { 
  if (args = Utils.staged_files('public/javascripts')).size > 0
    !system("git grep -n \"console\.log\" #{args}")
  else
    true
  end
}

Debugger = lambda {
  if (args = Utils.staged_files('app/', 'lib/', 'script/', 'vendor/')).size > 0
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

checks = [
          WhiteSpace, 
          ConsoleLog, 
          Debugger, 
          Tabs
          #ClosureSyntaxCheck
         ]

exit_status = checks.inject(true) do |acc, cmd|
  acc = cmd.call && acc
end

exit(exit_status ? 0 : 1)
