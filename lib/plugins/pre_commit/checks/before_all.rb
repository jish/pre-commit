require 'pre-commit/utils/grep'

module PreCommit
  module Checks
    class BeforeAll
      extend PreCommit::Utils::Grep

      def self.call(staged_files)
        staged_files.reject! { |f| File.extname(f) != ".rb" }
        return if staged_files.empty?
        errors = `#{grep} -e "before.*:all" #{staged_files.join(" ")} | grep -v \/\/`.strip
        return unless $?.success?
        "before(:all) found:\n#{errors}"
      end
    end
  end
end
