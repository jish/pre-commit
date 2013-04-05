module PreCommit
  class Utils

    def self.quote_array(arr)
      arr.map {|i| "'#{i}'"}.join ' '
    end

    def self.git_index_list(dirs, filter)
      dirs = dirs.map
      files = `git diff --cached --name-only --diff-filter=#{filter} #{quote_array dirs}`.split("\n")
      files.join " "
    end


    def self.staged_files(*dirs)
      dirs = reject_missing(dirs)

      @staged_files ||= {}
      @staged_files[quote_array dirs] ||= git_index_list dirs, 'ACM'
    end

    def self.new_files(*dirs)
      @new_files ||= {}
      @new_files[quote_array dirs] ||= git_index_list dirs, 'A'
    end

    def self.reject_missing(dirs)
      dirs.reject { |dir| !File.exist?(dir) }
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
