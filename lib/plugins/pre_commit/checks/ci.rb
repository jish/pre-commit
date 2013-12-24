module PreCommit
  module Checks
    class Ci
      CI_TASK_NAME = 'pre_commit:ci'

      def call(_)
        return if system("rake #{Ci::CI_TASK_NAME} --silent")
        "your test suite has failed, for the full output run `#{CI_TASK_NAME}`"
      end
    end
  end
end
