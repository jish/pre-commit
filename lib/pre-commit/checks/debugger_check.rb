module PreCommit
  class DebuggerCheck
    def self.call(staged_files)
      return if staged_files.empty?
      errors = `#{Utils.grep} debugger #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "debugger statement(s) found:\n#{errors}"
    end
  end
end
