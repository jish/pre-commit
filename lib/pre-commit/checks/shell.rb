require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Shell < Plugin

    private

      def execute(command, options = {})
        result = `#{command} 2>&1`
        $?.success? == (options.fetch(:success_status, true)) ? nil : result
      end
    end
  end
end
