require 'pre-commit/utils'

module PreCommit
  class BaseCheck
    def self.call(quiet=false)
      staged_files = Utils.staged_files(".").split(" ").select { |f| File.exist?(f) }
      error = run(staged_files)
      puts "#{error}\npre-commit: You can bypass this check using `git commit -n`" if error && !quiet
      !error
    end
  end
end
