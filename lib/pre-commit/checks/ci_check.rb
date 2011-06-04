class CiCheck

  def call
    if rakefile_present? && has_ci_task?
      run
    else
      $stderr.puts 'pre-commit: skipping ci check. `rake ci` is not defined.'

      # pretend the check passed and move on
      true
    end
  end

  def run
    if tests_passed?
      true
    else
      $stderr.puts 'pre-commit: your test suite has failed'
      $stderr.puts 'for the full output run `rake ci`'
      $stderr.puts

      false
    end
  end

  def tests_passed?
    system("rake ci --silent")
  end

  def rakefile_present?
    ['rakefile', 'Rakefile', 'rakefile.rb', 'Rakefile.rb'].any? do |file|
      File.exist?(file)
    end
  end

  def has_ci_task?
    require 'rake'
    Rake.application.init
    Rake.application.load_rakefile
    Rake::Task.task_defined?(:ci)
  rescue LoadError
    $stderr.puts 'pre-commit: rake not found, skipping ci check'
  end

end
