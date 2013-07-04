require 'pre-commit/checks/base_check'

module PreCommit
  class WhiteSpaceCheck < BaseCheck
    WHITESPACE_SCRIPT_PATH = File.expand_path("../../../support/whitespace/whitespace", __FILE__)

    def self.run(_)
      errors = `sh #{WHITESPACE_SCRIPT_PATH}`
      return if $?.success?
      errors
    end
  end
end
