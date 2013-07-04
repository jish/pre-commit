require 'pre-commit/checks/base_check'

module PreCommit
  class MergeConflictCheck < BaseCheck
    def self.run(staged_files)
      return if staged_files.empty?
      errors = `#{Utils.grep} '<<<<<<<' #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "detected a merge conflict\n#{errors}"
    end
  end
end
