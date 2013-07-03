require 'pre-commit/checks/base_check'

module PreCommit
  class CiCheck < BaseCheck
    CI_TASK_NAME = 'pre_commit:ci'

    def self.run(_)
      return if system("rake #{CI_TASK_NAME} --silent")
      "your test suite has failed, for the full output run `#{CI_TASK_NAME}`"
    end
  end
end
