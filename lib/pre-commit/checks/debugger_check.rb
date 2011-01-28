class DebuggerCheck
  attr_accessor :staged_files, :error_message, :grep_command

  def self.call(quiet=false)
    dirs = ['app/', 'lib/', 'script/', 'vendor/', 'test/'].reject {|d| !File.exists?(d)}
    check = new
    check.staged_files = Utils.staged_files(*dirs)

    result = check.run
    if !quiet && !result
      puts check.error_message
    end
    result
  end

  def run
    return true if staged_files.empty?

    if detected_bad_code?
      @error_message = "pre-commit: debugger statement found:\n"
      @error_message += instances_of_debugger_violations
      false
    else
      true
    end
  end

  def detected_bad_code?
    cmd = grep_command || "git grep"
    system("#{cmd} -nH -q debugger #{staged_files}")
  end

  def instances_of_debugger_violations
    cmd = grep_command || "git grep"
    `#{cmd} -nH debugger #{staged_files}`
  end

end
