require 'pre-commit/utils'

module PreCommit
  module Checks
    class GemfilePath
      def self.call(staged_files)
        return unless staged_files.include?("Gemfile")
        errors = `#{PreCommit::Utils.grep} 'path:|:path\\s*=>' Gemfile`.strip
        return unless $?.success?
        "local path found in Gemfile:\n#{errors}"
      end
    end
  end
end
