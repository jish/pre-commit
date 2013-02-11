module PreCommit
  class Runner

    def run
      checks_to_run = PreCommit.checks_to_run

      all_passed = checks_to_run.inject(true) do |current_status, check|
        passed = check.call

        if !passed && check.respond_to?(:error_message)
          puts check.error_message
        end

        check && current_status
      end

      exit(all_passed ? 0 : 1)
    end

  end
end
