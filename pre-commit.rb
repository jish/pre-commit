#!/usr/bin/env ruby



class Utils
  def self.staged_files(*dirs)
    @staged_files ||= `git diff --cached --name-only #{dirs.join(' ')} | xargs`.chomp
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
          #ClosureSyntaxCheck
         ]

exit_status = checks.inject(true) do |acc, cmd|
  acc = acc && cmd.call
end

exit(exit_status ? 0 : 1)
