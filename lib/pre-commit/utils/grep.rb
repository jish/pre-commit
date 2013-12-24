module PreCommit
  module Utils
    module Grep

      def grep(grep_version = nil)
        grep_version ||= detect_grep_version
        if grep_version =~ /FreeBSD/
          "grep -EnIH"
        else
          "grep -PnIH"
        end
      end

    private
      def detect_grep_version
        `grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)$/\1/'`
      end

    end
  end
end
