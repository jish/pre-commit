require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class MergeConflict
      extend PreCommit::Utils::Grep

      def self.call(staged_files)
        return if staged_files.empty?
        errors = `#{grep} '<<<<<<<' #{staged_files.join(" ")}`.strip
        return unless $?.success?
        "detected a merge conflict\n#{errors}"
      end
    end
  end
end
