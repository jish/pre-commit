require 'pre-commit/base'
require 'pre-commit/utils'
require 'pre-commit/checks/base_check'

module PreCommit
  class PhpCheck < BaseCheck
    def self.run(staged_files)
      staged_files = staged_files.grep /\.(php|engine|theme|install|inc|module|test)$/
      return if staged_files.empty?

      errors = staged_files.map { |file| run_check(file) }.compact
      return if errors.empty?

      errors.join("\n")
    end

    def self.run_check(file)
      # We force PHP to display errors otherwise they will likely end up in the
      # error_log and not in stdout.
      result = `php -d display_errors=1 -l #{file}`
      # Filter out the obvious note from PHP.
      result = result.split($/).find_all {|line| line !~ /Errors/}.join($/)
      # If PHP exited non-zero then there was a parse error.
      result.strip unless $? == 0
    end
  end
end
