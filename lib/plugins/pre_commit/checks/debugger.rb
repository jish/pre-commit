require 'pre-commit/utils'

module PreCommit::Checks
  class Debugger
    def self.call(staged_files)
      files = files_to_check(staged_files)
      return if files.empty?

      errors = `#{PreCommit::Utils.grep} debugger #{files.join(" ")}`.strip
      return unless $?.success?

      "debugger statement(s) found:\n#{errors}"
    end

    def self.files_to_check(files)
      files.reject { |file| File.basename(file) =~ /^Gemfile/ }
    end
  end
end
