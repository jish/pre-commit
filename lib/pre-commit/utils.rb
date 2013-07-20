module PreCommit
  class Utils

    def self.staged_files
      @staged_files ||= begin
        files = `git diff --cached --name-only --diff-filter=ACM`.split
        files.reject { |f| size = File.size(f); size > 1_000_000 || (size > 20 && binary?(f)) }
      end
    end

    # from https://github.com/djberg96/ptools/blob/master/lib/ptools.rb#L90
    def self.binary?(file)
      s = (File.read(file, File.stat(file).blksize) || "").split(//)
      ((s.size - s.grep(" ".."~").size) / s.size.to_f) > 0.30
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
