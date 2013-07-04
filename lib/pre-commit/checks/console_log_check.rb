require 'pre-commit/checks/base_check'

module PreCommit
  class ConsoleLogCheck < BaseCheck
    def self.run(staged_files)
      staged_files.reject! { |f| File.extname(f) != ".js" }
      return if staged_files.empty?
      errors = `#{Utils.grep} -e "console\\.log" #{staged_files.join(" ")} | grep -v \/\/`.strip
      return unless $?.success?
      "console.log found:\n#{errors}"
    end
  end
end
