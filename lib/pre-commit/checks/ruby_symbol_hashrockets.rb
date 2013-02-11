require 'pre-commit/utils'

module PreCommit
  class RubySymbolHashrockets

    attr_accessor :staged_files, :error_message

    HASHROCKET_PATTERN = ':(?:\$|@|@@|[_A-Za-z])?\w*[=!?]?\s*=>\s*'

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
      return true if staged_files.empty?

      if detected_bad_code?
        @error_message = "pre-commit: detected :symbol => value hashrocket:\n"
        @error_message += violations[:lines]

        @passed = false
      else
        @passed = true
      end

      @passed
    end

    def detected_bad_code?
      violations[:success]
    end

    def violations
      @violations ||= begin
        lines = `#{Utils.grep} '#{HASHROCKET_PATTERN}' #{staged_files}`
        success = $?.exitstatus == 0

        { :lines => lines, :success => success}
      end
    end

  end
end
