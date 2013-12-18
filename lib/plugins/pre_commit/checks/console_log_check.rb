module PreCommit::Checks
  class ConsoleLogCheck
    def self.supports(name)
      name == :console_log
    end
    def self.call(staged_files)
      staged_files.reject! { |f| File.extname(f) != ".js" }
      return if staged_files.empty?
      errors = `#{PreCommit::Utils.grep} -e "console\\.log" #{staged_files.join(" ")} | grep -v \/\/`.strip
      return unless $?.success?
      "console.log found:\n#{errors}"
    end
  end
end
