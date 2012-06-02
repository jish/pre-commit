# coding: utf-8

class Sanity

  attr_accessor :staged_files, :error_message

  def self.call(quiet=false)
    check = new
    check.staged_files = Utils.staged_files('*')

    result = check.run
    if !quiet && !result
      $stderr.puts check.error_message
      $stderr.puts
      check.print_dash_n_reminder
    end
    result
  end

  def run
    return true if staged_files.empty?

    if detected_bad_code?
      @error_message = "pre-commit: detected bad character:\n"
      @error_message += violations
      false
    else
      true
    end
  end

  BAD_CHARACTER_PATTERN = ' | ' # invisible utf-8 characters...

  def detected_bad_code?
    system "grep -PnIH -q '#{BAD_CHARACTER_PATTERN}' #{staged_files}"
  end

  def violations
    `grep -PnIH '#{BAD_CHARACTER_PATTERN}' #{staged_files}`
  end

  def print_dash_n_reminder
    $stderr.puts 'You can bypass this check using `git commit -n`'
    $stderr.puts
  end

end
