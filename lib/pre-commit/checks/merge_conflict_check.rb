require 'pre-commit/checks/base_check'

module PreCommit
  class MergeConflictCheck < BaseCheck
    def self.run(staged_files)
      return if staged_files.empty? || !detected_bad_code?(staged_files)
      "detected a merge conflict\n#{errors(staged_files)}"
    end

    def self.detected_bad_code?(staged_files)
      system("grep -q '<<<<<<<' #{staged_files.join(" ")} --quiet")
    end

    def self.errors(staged_files)
      `grep -nH '<<<<<<<' #{staged_files.join(" ")}`.strip
    end
  end
end
