require 'fileutils'
require 'pre-commit/base'

module PreCommit
  class Cli

    PRE_COMMIT_HOOK_PATH = '.git/hooks/pre-commit'

    def answered_yes?(answer)
      answer =~ /y\n/i || answer == "\n"
    end

    def install(force)
      if !force && File.exists?(PRE_COMMIT_HOOK_PATH)
        ask_to_overwrite
      end

      install_pre_commit_hook
    end

    def ask_to_overwrite
      puts "pre-commit: WARNING There is already a pre-commit hook installed in this git repo."
      print "Would you like to overwrite it? [Yn] "
      answer = $stdin.gets

      if answered_yes?(answer)
        FileUtils.rm(PRE_COMMIT_HOOK_PATH)
      else
        puts "Not overwriting existing hook: #{PRE_COMMIT_HOOK_PATH}"
        puts
        exit(1)
      end
    end

    def install_pre_commit_hook
      hook = File.join(PreCommit.root, 'templates', 'pre-commit-hook')
      FileUtils.cp(hook, PRE_COMMIT_HOOK_PATH)
      FileUtils.chmod(0755, PRE_COMMIT_HOOK_PATH)
    end

  end
end
