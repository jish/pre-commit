module PreCommit::Checks
  class RspecFocusCheck
    def self.supports(name)
      name == :rspec_focus
    end
    def self.call(staged_files)
      staged_files = staged_files.grep(/_spec\.rb$/)
      return if staged_files.empty?
      result = `#{PreCommit::Utils.grep} ':focus' #{staged_files.join(" ")}`.strip
      return unless $?.success?
      ":focus found in specs:\n#{result}"
    end
  end
end
