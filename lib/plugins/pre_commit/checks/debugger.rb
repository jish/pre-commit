require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class Debugger
      extend PreCommit::Utils::Grep

      def self.call(staged_files)
        files = files_to_check(staged_files)
        return if files.empty?

        errors = `#{grep} debugger #{files.join(" ")}`.strip
        return unless $?.success?

        "debugger statement(s) found:\n#{errors}"
      end

      def self.files_to_check(files)
        files.reject { |file| File.basename(file) =~ /^Gemfile/ }
      end
    end
  end
end
