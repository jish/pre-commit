require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Ci < Plugin
      CI_TASK_NAME = 'pre_commit:ci'

      def call(_)
        cmd = 'bin/rake'
        cmd = 'bundle exec rake' unless File.exist? cmd
        return if system("#{cmd} #{Ci::CI_TASK_NAME} --silent")
        PreCommit::ErrorList.new(
          "your test suite has failed, for the full output run `#{CI_TASK_NAME}`"
        )
      end

      def self.description
        "Runs 'rake #{CI_TASK_NAME} --silent'"
      end
    end
  end
end
