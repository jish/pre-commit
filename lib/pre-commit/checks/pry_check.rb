require 'pre-commit/checks/base_check'

module PreCommit
  class PryCheck < BaseCheck
    def self.run(staged_files)
      return if staged_files.empty?
      result = `#{Utils.grep} binding.pry #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "binding.pry found:\n#{result}"
    end
  end
end
