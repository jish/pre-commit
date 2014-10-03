require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Local < Plugin

      attr_writer :script

      def call(staged_files)
        return unless script
        output = `ruby #{script} #{staged_files.join(" ")} 2>&1`
        "#{script} failed:\n#{output}" unless $?.success?
      end

      def self.description
        "Executes a custom script located at config/pre_commit.rb"
      end

      def script
        @script ||= ["config/pre_commit.rb", "config/pre-commit.rb"].detect do |file|
          File.exist?(file)
        end
      end

    end
  end
end
