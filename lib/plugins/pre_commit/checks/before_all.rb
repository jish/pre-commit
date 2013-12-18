module PreCommit::Checks
  class BeforeAll
    def self.call(staged_files)
      staged_files.reject! { |f| File.extname(f) != ".rb" }
      return if staged_files.empty?
      errors = `#{PreCommit::Utils.grep} -e "before.*:all" #{staged_files.join(" ")} | grep -v \/\/`.strip
      return unless $?.success?
      "before(:all) found:\n#{errors}"
    end
  end
end
