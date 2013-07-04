require 'pre-commit/utils'
require 'pre-commit/checks/base_check'

module PreCommit
  class RubySymbolHashrockets < BaseCheck
    HASHROCKET_PATTERN = '[^:](:{1}(?:\$|@|@@|[_A-Za-z])?\w*[=!?]?\s*=>\s*)'

    def self.run(staged_files)
      return if staged_files.empty?
      lines = `#{Utils.grep} '#{HASHROCKET_PATTERN}' #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "detected :symbol => value hashrocket:\n#{lines}"
    end
  end
end
