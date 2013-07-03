require 'pre-commit/checks/base_check'

module PreCommit
  class ConsoleLogCheck < BaseCheck
    def self.run(staged_files)
      staged_files.reject! { |f| File.extname(f) != ".js" }
      return if staged_files.empty? || !detected_bad_code?(staged_files)
      "console.log found:\n#{instances_of_console_log_violations(staged_files)}"
    end

    def self.detected_bad_code?(staged_files)
      system("grep -v \/\/ #{staged_files.join(" ")} | grep -qe \"console\\.log\"")
    end

    def self.instances_of_console_log_violations(staged_files)
      `grep -nHe \"console\\.log\" #{staged_files.join(" ")}`
    end
  end
end
