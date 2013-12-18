require 'pre-commit/utils'

module PreCommit::Checks
  class GemfilePathCheck
    def self.supports(name)
      name == :gemfile_path
    end
    def self.call(staged_files)
      return unless staged_files.include?("Gemfile")
      errors = `#{PreCommit::Utils.grep} 'path:|:path\\s*=>' Gemfile`.strip
      return unless $?.success?
      "local path found in Gemfile:\n#{errors}"
    end
  end
end
