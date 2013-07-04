require 'pre-commit/checks/base_check'

module PreCommit
  class RSpecFocusCheck < BaseCheck
    def self.run(staged_files)
      staged_files = staged_files.grep(/_spec\.rb$/)
      return if staged_files.empty?
      result = `#{Utils.grep} ':focus' #{staged_files.join(" ")}`.strip
      return unless $?.success?
      ":focus found in specs:\n#{result}"
    end
  end
end
