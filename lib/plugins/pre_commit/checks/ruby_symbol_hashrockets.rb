require 'pre-commit/utils'

module PreCommit::Checks
  class RubySymbolHashrockets
    HASHROCKET_PATTERN = '[^:](:{1}(?:\$|@|@@|[_A-Za-z])?\w*[=!?]?\s*=>\s*)'

    def self.supports(name)
      name == :ruby_symbol_hashrockets
    end
    def self.call(staged_files)
      return if staged_files.empty?
      lines = `#{PreCommit::Utils.grep} '#{HASHROCKET_PATTERN}' #{staged_files.join(" ")}`.strip
      return unless $?.success?
      "detected :symbol => value hashrocket:\n#{lines}"
    end
  end
end
