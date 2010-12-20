class ConsoleLog

  attr_accessor :staged_files, :error_message

  def run
    if detected_bad_code?
      @error_message = "pre-commit: console.log found:\n"
      @error_message += instances_of_console_log_violations
      false
    else
      true
    end
  end

  def detected_bad_code?
    system("grep -q 'console.log' #{staged_files}")
  end

  def instances_of_console_log_violations
    `grep -nH 'console.log' #{staged_files}`
  end

end
