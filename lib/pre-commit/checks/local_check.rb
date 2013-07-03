require 'pre-commit/checks/base_check'

module PreCommit
  class LocalCheck < BaseCheck
    DEFAULT_LOCATION = "config/pre-commit.rb"

    def self.run(staged_files, script=DEFAULT_LOCATION)
      return unless File.exist?(script)
      output = `ruby #{script} #{staged_files.join(" ")} 2>&1`
      "#{script} failed:\n#{output}" unless $?.success?
    end
  end
end
