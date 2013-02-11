class PreCommit::MergeConflict

  attr_accessor :staged_files

  def self.call
    check = new
    check.staged_files = Utils.staged_files('.')
    check.run
  end

  def run
    if detected_bad_code?
      $stderr.puts 'pre-commit: detected a merge conflict'
      $stderr.puts errors
      $stderr.puts
      $stderr.puts 'pre-commit: You can bypass this check using `git commit -n`'
      $stderr.puts
      false
    else
      true
    end
  end

  def detected_bad_code?
    system("grep '<<<<<<<' #{staged_files} --quiet")
  end

  def errors
    `grep -nH '<<<<<<<' #{staged_files}`
  end

end
