module PreCommit
  class RSpecFocusCheck

    attr_accessor :staged_files, :error_message, :grep_command, :spec_files

    def self.call(quiet=false)
      dirs = ['spec/'].reject {|d| !File.exists?(d)}
      check = new
      check.staged_files = Utils.staged_files(*dirs)

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
        @error_message = "pre-commit: :focus in spec(s) found:\n"
        @error_message += instances_of_rspec_focus_violations
        false
      else
        true
      end
    end

    def detected_bad_code?
      spec_files = staged_files.split(' ').select do |file|
        file =~ /_spec\.rb$/
      end

      return false if spec_files.empty?

      passed = true

      spec_files.each do |spec|
        diff = `git diff --cached -G:focus #{spec}`
        passed &&= !(diff =~ /[\W\s]:focus[\W\s]/)
      end

      return !passed
    end

    def instances_of_rspec_focus_violations
      cmd = grep_command || "git grep"
      `#{cmd} -nHw ':focus' #{staged_files}`
    end

    def print_dash_n_reminder
      $stderr.puts 'You can bypass this check using `git commit -n`'
      $stderr.puts
    end

  end
end
