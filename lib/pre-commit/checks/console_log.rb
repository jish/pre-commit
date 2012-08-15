class ConsoleLog

  attr_accessor :staged_files, :error_message

  def self.call(quiet=false)
    check = new
    check.staged_files = Utils.staged_files('public/javascripts')

    result = check.run
    if !quiet && !result
      puts check.error_message
    end
    result
  end

  def run
    return true if staged_js_files.empty?
    if detected_bad_code?
      @error_message = "pre-commit: console.log found:\n"
      @error_message += instances_of_console_log_violations
      false
    else
      true
    end
  end

  def detected_bad_code?
    system("grep -v \/\/ #{staged_js_files} | grep -qe \"console\\.log\"")
  end

  def instances_of_console_log_violations
    `grep -nHe \"console\\.log\" #{staged_js_files}`
  end

  def staged_js_files
    @staged_js_files ||= staged_files.split(" ").select do |file|
      File.extname(file) == ".js"
    end.join(" ")
  end
end
