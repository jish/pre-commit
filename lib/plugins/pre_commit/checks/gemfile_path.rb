require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class GemfilePath
      extend PreCommit::Utils::Grep

      def self.call(staged_files)
        return unless staged_files.include?("Gemfile")
        errors = `#{grep} 'path:|:path\\s*=>' Gemfile`.strip
        return unless $?.success?
        "local path found in Gemfile:\n#{errors}"
      end
    end
  end
end
