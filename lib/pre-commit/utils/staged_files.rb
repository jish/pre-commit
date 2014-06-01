module PreCommit
  module Utils
    module StagedFiles

      def staged_files
        @staged_files ||= begin
          files = `git diff --cached --name-only --diff-filter=ACM`.split
          files.reject do |f|
            size = File.size(f);
            File.directory?(f) ||
              size > 1_000_000 ||
              (size > 20 && binary?(f))
          end
        end
      end

    private
      # from https://github.com/djberg96/ptools/blob/master/lib/ptools.rb#L90
      def binary?(file)
        s = (File.read(file, File.stat(file).blksize) || "").split(//)
        ((s.size - s.grep(" ".."~").size) / s.size.to_f) > 0.30
      end

    end
  end
end
