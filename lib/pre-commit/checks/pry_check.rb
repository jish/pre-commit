require 'pre-commit/checks/base_check'

module PreCommit
  class PryCheck < BaseCheck
    def self.run(staged_files)
      return if staged_files.empty?
      result = `grep -nH binding.pry #{staged_files.join(" ")}`.strip
      "binding.pry found:\n#{result}" if $?.success?
    end
  end
end
