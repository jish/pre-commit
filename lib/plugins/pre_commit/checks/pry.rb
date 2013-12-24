require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class Pry
      extend PreCommit::Utils::Grep

      def self.call(staged_files)
        return if staged_files.empty?
        result = `#{grep} binding.pry #{staged_files.join(" ")}`.strip
        return unless $?.success?
        "binding.pry found:\n#{result}"
      end
    end
  end
end
