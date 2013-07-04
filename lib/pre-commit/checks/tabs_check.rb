require 'pre-commit/checks/base_check'

module PreCommit
  class TabsCheck < BaseCheck
    LEADING_TAB_PATTERN = '^ *\t'

    def self.run(staged_files)
      return if staged_files.empty?
      errors = `#{Utils.grep} '#{LEADING_TAB_PATTERN}' #{staged_files.join(" ")}`
      return unless $?.success?
      "detected tab before initial space:\n#{errors}"
    end
  end
end
