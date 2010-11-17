
#!/usr/bin/env ruby

WhiteSpace = lambda { system("sh ./.git/hooks/whitespace") }

ConsoleLog = lambda { 
  if (args = `git diff --cached --name-only public/javascripts/ | xargs`).size > 0
    !system("git grep \"console\.log\" #{args}")
  else
    true
  end
}

Debugger = lambda {
  if (args = `git diff --cached --name-only app/ lib/ script/ vendor/ | xargs`).size > 0
    !system("git grep debugger #{args}")
  else
    true
  end
}

checks = [WhiteSpace, ConsoleLog, Debugger]

exit_status = checks.inject(true) do |acc, cmd|
  acc = acc && cmd.call
end

exit(exit_status ? 0 : 1)
