require 'pre-commit/utils'

module PreCommit
  class BaseCheck
    def self.call(quiet=false)
      error = run(Utils.staged_files(".").split(" "))
      puts error if error && !quiet
      !error
    end
  end
end
