require 'pre-commit/checks/base_check'

module PreCommit
  class DebuggerCheck < BaseCheck
    def self.run(staged_files)
      return if staged_files.empty?
      errors = `#{Utils.grep} debugger #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "debugger statement(s) found:\n#{errors}"
    end
  end
end
