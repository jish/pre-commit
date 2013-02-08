class PreCommit::Tabs

  attr_accessor :staged_files, :error_message

  # Maintaining the functionality of `call` for backwards compatibility
  # Currently, the call method is expected to:
  # * run a check
  # * print any corresponding error messages if the check fails
  def self.call
    check = new
    check.staged_files = Utils.staged_files('*')
    result = check.run

    if !result
      $stderr.puts check.error_message
      $stderr.puts
      $stderr.puts 'pre-commit: You can bypass this check using `git commit -n`'
      $stderr.puts
    end

    result
  end

  def run
    # There is nothing to check
    if staged_files.empty?
      return true
    end

    if detected_bad_code?
      @error_message = "pre-commit: detected tab before initial space:\n"
      @error_message += violations

      @passed = false
    else
      @passed = true
    end
  end

  LEADING_TAB_PATTERN = '^ *\t'

  def detected_bad_code?
    system("#{Utils.grep} -q '#{LEADING_TAB_PATTERN}' #{staged_files}")
  end

  def violations
    `#{Utils.grep} '#{LEADING_TAB_PATTERN}' #{staged_files}`
  end
end
