require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Shell < Plugin

    private

      def execute(command)
        _, stdout, stderr, process = Open3.popen3(command)
        stdout.read + stderr.read unless process.value.success?
      end
    end
  end
end
