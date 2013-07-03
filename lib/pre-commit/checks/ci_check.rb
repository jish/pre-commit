module PreCommit
  class CiCheck

    CI_TASK_NAME = 'pre_commit:ci'

    def call
      if system("rake #{CI_TASK_NAME} --silent")
        true
      else
        $stderr.puts 'pre-commit: your test suite has failed'
        $stderr.puts "for the full output run `#{CI_TASK_NAME}`"
        $stderr.puts

        false
      end
    end

  end
end
