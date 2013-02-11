require 'pre-commit/base'
require 'pre-commit/utils'

module PreCommit
  class PhpCheck

    def files_to_check
      Utils.staged_files('.').split(" ")
    end

    def call
      php_files = reject_non_php(files_to_check)
      if should_run?(php_files)
        run(php_files)
      else
        # pretend the check passed and move on
        true
      end
    end

    def check_name
      "PHP Lint"
    end

    def run(php_files)
      errors = []

      php_files.each do |file|
        error = run_check(file)
        unless error.nil?
          errors << display_error(error)
        end
      end

      if errors.empty?
        true
      else
        $stderr.puts errors.join("\n")
        $stderr.puts
        $stderr.puts 'pre-commit: You can bypass this check using `git commit -n`'
        $stderr.puts
        false
      end
    end

    def should_run?(php_files)
      php_files.any?
    end

    def reject_non_php(staged_files)
      staged_files.select { |f| f =~ /\.(php|engine|theme|install|inc|module|test)$/ }
    end

    def run_check(file)
      # We force PHP to display errors otherwise they will likely end up in the
      # error_log and not in stdout.
      cmd = "php -d display_errors=1 -l #{file}"
      result = %x[ #{cmd} ]
      # Filter out the obvious note from PHP.
      result = result.split($/).find_all {|line| line !~ /Errors/}.join($/)
      # If PHP exited non-zero then there was a parse error.
      if ($? != 0)
        result
      end
    end

    # Format an error line.
    def display_error(error)
      "pre-commit: #{check_name.upcase} #{error}"
    end

  end
end
