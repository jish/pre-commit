require 'fileutils'

module PreCommit
  class Cli

    PRE_COMMIT_HOOK_PATH = '.git/hooks/pre-commit'

    def install
      hook = File.expand_path("../support/templates/pre-commit-hook", __FILE__)
      FileUtils.cp(hook, PRE_COMMIT_HOOK_PATH)
      FileUtils.chmod(0755, PRE_COMMIT_HOOK_PATH)
    end

  end
end
