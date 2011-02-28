class Tabs

  attr_accessor :staged_files, :error_message

  # Maintaining the functionality of `call` for backwards compatibility
  # Currently, the call method is expected to:
  # * run a check
  # * print any corresponding error messages if the check fails
  def self.call
    check = new
    check.staged_files = Utils.staged_files('*')
    check.run
  end

  def run
    # There is nothing to check
    if staged_files.empty?
      return true
    end

    if detected_bad_code?
      @error_message = "pre-commit: detected tab before initial space:\n"
      @error_message += violations

      $stderr.puts @error_message
      $stderr.puts

      @passed = false
    else
      @passed = true
    end
  end

  def detected_bad_code?
    system("grep -PnIH -q '^\t' #{staged_files}")
  end

  def violations
    `grep -PnIH '^\t' #{staged_files}`
  end

end
