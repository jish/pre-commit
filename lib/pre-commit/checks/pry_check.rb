module PreCommit
  class PryCheck

    attr_accessor :staged_files, :error_message, :grep_command

    def self.call(quiet=false)
      dirs = ['app/', 'lib/', 'script/', 'vendor/', 'test/'].reject {|d| !File.exists?(d)}
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
        @error_message = "pre-commit: binding.pry statement(s) found:\n"
        @error_message += instances_of_pry_violations
        false
      else
        true
      end
    end

    def detected_bad_code?
      !system("git diff --cached -S binding.pry --quiet --exit-code")
    end

    def instances_of_pry_violations
      cmd = grep_command || "git grep"
      `#{cmd} -nH "binding\.pry" #{staged_files}`
    end

    def print_dash_n_reminder
      $stderr.puts 'You can bypass this check using `git commit -n`'
      $stderr.puts
    end

  end
end
