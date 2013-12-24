require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class Tabs
      extend PreCommit::Utils::Grep

      LEADING_TAB_PATTERN = '^ *\t'

      def self.call(staged_files)
        return if staged_files.empty?
        errors = `#{grep} '#{LEADING_TAB_PATTERN}' #{staged_files.join(" ")}`.strip
        return unless $?.success?
        "detected tab before initial space:\n#{errors}"
      end
    end
  end
end
