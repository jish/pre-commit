require "pre-commit/configuration/top_level"

module PreCommit
  module Utils
    module StagedFiles
      include PreCommit::Configuration::TopLevel

      def set_staged_files(*args)
        case args[0].to_s
        when "all" then staged_files_all
        when "git" then staged_files_git_all
        when "" then staged_files
        else self.staged_files=args
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

      def staged_files_git_all
        @staged_files = filter_files(staged_from_git_all)
      end

    private
      # from https://github.com/djberg96/ptools/blob/master/lib/ptools.rb#L90
      def binary?(file)
        bytes = File.stat(file).blksize.to_i
        bytes = 4096 if bytes > 4096
        s = (File.read(file, bytes) || "").split(//)

        ((s.size - s.grep(" ".."~").size) / s.size.to_f) > 0.30
      end

      def filter_files(files)
        files.reject do |file|
          !File.exists?(file) ||
          File.directory?(file) ||
          (
            size = File.size(file)
            size > 1_000_000 || (size > 20 && binary?(file))
          ) ||
          repo_ignores.any? { |ignore| File.fnmatch?(ignore, file) }
        end
      end

      def staged_from_git
        `git diff --cached --name-only --diff-filter=ACM`.split(/\n/)
      end

      def staged_from_git_all
        `git ls-files`.split(/\n/)
      end

      def staged_from_dir
        Dir["**/*"]
      end

      def repo_ignores_file
        File.join(top_level, ".pre_commit.ignore")
      end

      def repo_ignores
        @repo_ignores ||= File.read(repo_ignores_file).split("\n").compact
      rescue Errno::ENOENT
        @repo_ignores = []
      end

    end
  end
end
