module PreCommit::Checks
  class MergeConflict
    def self.call(staged_files)
      return if staged_files.empty?
      errors = `#{PreCommit::Utils.grep} '<<<<<<<' #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "detected a merge conflict\n#{errors}"
    end
  end
end
