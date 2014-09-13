require 'pre-commit/checks/shell'
require 'shellwords'

module PreCommit
  module Checks
    class Grep < Shell
      class PaternNotSet < StandardError
        def message
          "Please define 'pattern' method."
        end
      end

    # overwrite those:

      def files_filter(staged_files)
        staged_files
      end

      def extra_grep
        @extra_grep or ""
      end

      def message
        @message or ""
      end

      def pattern
        @pattern or raise PaternNotSet.new
      end

    # general code:

      def call(staged_files)
        staged_files = files_filter(staged_files).map(&:shellescape)
        return if staged_files.empty?
        args = ([grep, pattern] + staged_files + [extra_grep]).join(" ")
        errors = execute(args, success_status: false)
        errors and "#{message}#{errors}"
      end

    private

      def grep(grep_version = nil)
        grep_version ||= detect_grep_version
        if grep_version =~ /FreeBSD/
          "grep -EnIH"
        else
          "grep -PnIH"
        end
      end

      def detect_grep_version
        `grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)$/\1/'`
      end

    end
  end
end
