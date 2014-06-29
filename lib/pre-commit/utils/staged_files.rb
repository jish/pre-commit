module PreCommit
  module Utils
    module StagedFiles

      def set_staged_files(*args)
        case args[0].to_s
        when "all" then staged_files_all
        when "" then staged_files
        else staged_files=args
        end
      end

      def staged_files=(args)
        @staged_files = args
      end

      def staged_files
        @staged_files ||= filter_files(staged_from_git)
      end

      def staged_files_all
        @staged_files = filter_files(staged_from_dir)
      end

    private
      # from https://github.com/djberg96/ptools/blob/master/lib/ptools.rb#L90
      def binary?(file)
        s = (File.read(file, File.stat(file).blksize) || "").split(//)
        ((s.size - s.grep(" ".."~").size) / s.size.to_f) > 0.30
      end

      def filter_files(files)
        files.reject do |f|
          File.directory?(f) ||
          {
            size = File.size(f)
            size > 1_000_000 || (size > 20 && binary?(f))
          }
        end
      end

      def staged_from_git
        `git diff --cached --name-only --diff-filter=ACM`.split(/\n/)
      end

      def staged_from_dir
        Dir["**/*"]
      end

    end
  end
end
