require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class RubySymbolHashrockets
      extend PreCommit::Utils::Grep

      HASHROCKET_PATTERN = '[^:](:{1}(?:\$|@|@@|[_A-Za-z])?\w*[=!?]?\s*=>\s*)'

      def self.call(staged_files)
        return if staged_files.empty?
        lines = `#{grep} '#{HASHROCKET_PATTERN}' #{staged_files.join(" ")}`.strip
        return unless $?.success?
        "detected :symbol => value hashrocket:\n#{lines}"
      end
    end
  end
end
