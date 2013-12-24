require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class ConsoleLog
      extend PreCommit::Utils::Grep

      def self.call(staged_files)
        staged_files.reject! { |f| File.extname(f) != ".js" }
        return if staged_files.empty?
        errors = `#{grep} -e "console\\.log" #{staged_files.join(" ")} | grep -v \/\/`.strip
        return unless $?.success?
        "console.log found:\n#{errors}"
      end
    end
  end
end
