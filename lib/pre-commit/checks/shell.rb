require 'pre-commit/checks/plugin'
require 'shellwords'

module PreCommit
  module Checks
    class Shell < Plugin

    private

      def execute(*args)
        options = args.last.is_a?(::Hash) ? args.pop : {}
        args = build_command(*args)
        execute_raw(args, options)
      end

      def build_command(*args)
        args.flatten.map do |arg|
          arg = arg.shellescape if arg != '|' && arg != '&&' && arg != '||'
          arg
        end.join(" ")
      end

      def execute_raw(command, options = {})
        result = `#{command} 2>&1`
        $?.success? == (options.fetch(:success_status, true)) ? nil : result
      end
    end
  end
end
