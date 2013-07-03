require 'pre-commit/checks/base_check'

module PreCommit
  class DebuggerCheck < BaseCheck
    def self.run(staged_files)
      return if staged_files.empty? || !detected_bad_code?(staged_files)
      "debugger statement(s) found:\n#{instances_of_debugger_violations(staged_files)}"
    end

    def self.detected_bad_code?(staged_files)
      system("grep -nHq debugger #{staged_files.join(" ")}")
    end

    def self.instances_of_debugger_violations(staged_files)
      `grep -nH debugger #{staged_files.join(" ")}`.strip
    end
  end
end
