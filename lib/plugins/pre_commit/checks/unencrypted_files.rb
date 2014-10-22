require 'pre-commit/checks/grep'

module PreCommit
  module Checks
    class UnencryptedFiles < Grep

      def files_filter(staged_files)
        staged_files.grep(/.secure$/)
      end

      def message
        "trying to commit unencrypted .secure files"
      end

      def pattern
        "^UNENCRYPTED_FILE_ALERT"
      end

      def extra_grep
        %w{-v #}
      end

      def self.description
        "Checks for unencrypted .secure files"
      end

    end
  end
end
