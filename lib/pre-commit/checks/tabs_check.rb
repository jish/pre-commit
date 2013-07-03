require 'pre-commit/checks/base_check'

module PreCommit
  class TabsCheck < BaseCheck
    LEADING_TAB_PATTERN = '^ *\t'

    def self.run(staged_files)
      return if staged_files.empty? || !detected_bad_code?(staged_files)
      "detected tab before initial space:\n#{violations(staged_files)}"
    end

    def self.detected_bad_code?(staged_files)
      system("#{Utils.grep} -q '#{LEADING_TAB_PATTERN}' #{staged_files.join(" ")}")
    end

    def self.violations(staged_files)
      `#{Utils.grep} '#{LEADING_TAB_PATTERN}' #{staged_files.join(" ")}`
    end
  end
end
