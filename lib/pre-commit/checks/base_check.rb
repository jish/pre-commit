require 'pre-commit/utils'

module PreCommit
  class BaseCheck
    def self.call(quiet=false)
      error = run(Utils.staged_files(".").split(" "))
      puts "#{error}\npre-commit: You can bypass this check using `git commit -n`" if error && !quiet
      !error
    end
  end
end
