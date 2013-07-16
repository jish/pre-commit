module PreCommit
  class Utils

    def self.staged_files
      @staged_files ||= `git diff --cached --name-only --diff-filter=ACM`.split
    end

    def self.grep
      grep_version = `grep --version | head -n 1 | sed -e 's/^[^0-9.]*\([0-9.]*\)$/\1/'`
      if grep_version =~ /FreeBSD/
        "grep -EnIH"
      else
        "grep -PnIH"
      end
    end

  end
end
