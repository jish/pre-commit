module PreCommit
  module Checks
    class Local
      DEFAULT_LOCATION = "config/pre-commit.rb"

      def call(staged_files, script=Local::DEFAULT_LOCATION)
        return unless File.exist?(script)
        output = `ruby #{script} #{staged_files.join(" ")} 2>&1`
        "#{script} failed:\n#{output}" unless $?.success?
      end
    end
  end
end
