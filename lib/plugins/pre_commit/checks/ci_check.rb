module PreCommit::Checks
  class CiCheck
    CI_TASK_NAME = 'pre_commit:ci'

    def self.supports(name)
      name == :ci
    end
    def self.call(_)
      return if system("rake #{CI_TASK_NAME} --silent")
      "your test suite has failed, for the full output run `#{CI_TASK_NAME}`"
    end
  end
end
