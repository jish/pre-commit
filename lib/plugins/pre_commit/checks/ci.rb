require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    ##
    # The CI check will run `rake pre_commmit:ci` before the commit and check
    # its exit code. If the task runs successfully, the commit will proceed.
    # If it fails, the commit will be aborted.
    #
    class Ci < Plugin
      CI_TASK_NAME = 'pre_commit:ci'

      def self.description
        "Runs 'rake #{CI_TASK_NAME} --silent'"
      end

      def call(_)
        return if system("rake", CI_TASK_NAME, "--silent")

        PreCommit::ErrorList.new(
          "your test suite has failed, for the full output run `#{CI_TASK_NAME}`"
        )
      end
    end
  end
end
