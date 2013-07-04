require 'pre-commit/checks/base_check'

module PreCommit
  class RSpecFocusCheck < BaseCheck
    def self.run(staged_files)
      staged_files = staged_files.grep(/_spec\.rb$/)
      return if staged_files.empty?
      result = `grep -nH ':focus' #{staged_files.join(" ")}`.strip
      ":focus found in specs:\n#{result}" if $?.success?
    end
  end
end
