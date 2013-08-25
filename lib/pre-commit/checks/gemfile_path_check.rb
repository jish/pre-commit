require 'pre-commit/utils'

module PreCommit
  class GemfilePathCheck
    def self.call(staged_files)
      return unless staged_files.include?("Gemfile")
      errors = `#{Utils.grep} 'path:|:path\\s*=>' Gemfile`.strip
      return unless $?.success?
      "local path found in Gemfile:\n#{errors}"
    end
  end
end
