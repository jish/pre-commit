# frozen-string-literal: true

require 'pre-commit/configuration/top_level'

module PreCommit
  module Utils
    module StagedFiles
      include PreCommit::Configuration::TopLevel

      BINARIES = [
        ".dmg", ".gz", ".img", ".iso", ".rar", ".tar", ".xz", ".zip"
      ].freeze
      IMAGES = [".gif", ".ico", ".jpeg", ".jpg", ".pdf", ".png"].freeze
      IGNORED_EXTENSIONS = BINARIES + IMAGES

      SOURCE_FILES = [
        ".coffee", ".css", ".erb", ".feature", ".html", ".js", ".json",
        ".liquid", ".md", ".rb", ".sass", ".scss", ".slim", ".yml"
      ].freeze

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

      # Definitely include this file in the checks.
      def source_file?(filename)
        SOURCE_FILES.include?(File.extname(filename))
      end

      # Try to bail out quickly based on filename.
      #
      # If the extension is `.jpg` this is likely not a source code file.
      # So let's not waste time checking to see if it's "binary" (as best we
      # can guess) and let's not run any checks on it.
      def ignore_extension?(filename)
        IGNORED_EXTENSIONS.include?(File.extname(filename))
      end

      # Make a best guess to determine if this is a binary file.
      # This is not an exact science ;)
      def appears_binary?(filename)
        size = File.size(filename)
        size > 1_000_000 || (size > 20 && binary?(filename))
      end

      def repo_ignored?(filename)
        repo_ignores.any? { |ignore| File.fnmatch?(ignore, filename) }
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
        first_pass = files.reject do |file|
          repo_ignored?(file) ||
          ignore_extension?(file) ||
          File.directory?(file) ||
          !File.exists?(file)
        end

        # If it's a source file, definitely check it.
        # Otherwise, attempt to guess if the file is binary or not.
        first_pass.select do |file|
          source_file?(file) || !appears_binary?(file)
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
