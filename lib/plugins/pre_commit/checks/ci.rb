module PreCommit::Checks
  class Ci
    CI_TASK_NAME = 'pre_commit:ci'

    def self.call(_)
      return if system("rake #{CI_TASK_NAME} --silent")
      "your test suite has failed, for the full output run `#{CI_TASK_NAME}`"
    end
  end
end
