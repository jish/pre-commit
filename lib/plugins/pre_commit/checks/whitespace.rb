require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Whitespace < Plugin

      def self.aliases
        [:white_space]
      end

      def files_filter(staged_files)
        if
          @list.map(&:name).include?("PreCommit::Checks::Rubocop")
        then
          staged_files.reject{|name| name =~ /\.rb$/ }
        else
          staged_files
        end
      end

      def files_string(staged_files)
        files_filter(staged_files).map{|file| "'#{file}'" }.join(" ")
      end

      def call(staged_files)
        return if staged_files.empty?

        errors = `git diff-index --check --cached HEAD -- #{files_string(staged_files)} 2>&1`
        return if $?.success?

        # Initial commit: diff against the empty tree object
        if errors =~ /fatal: bad revision 'HEAD'/
          errors = `git diff-index --check --cached 4b825dc642cb6eb9a060e54bf8d69288fbee4904 -- 2>&1`
          return if $?.success?
        end

        errors
      end

      def self.description
        "Finds white space."
      end

    end
  end
end
