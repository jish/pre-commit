require 'pre-commit/checks/plugin'

module PreCommit
  module Checks
    class Js < Plugin
      def call(staged_files)
        require 'execjs'
      rescue RuntimeError, LoadError => e
        $stderr.puts "Could not load execjs: #{e}. You need to manually install execjs to use JavaScript plugins for security reasons."
      else
        staged_files = files_filter(staged_files)
        return if staged_files.empty?

        errors = []
        staged_files.each do |file|
          error_list = Array(run_check(file))
          error_list.each { |error_object| errors << display_error(error_object, file) }
        end

        return if errors.empty?
        errors.join("\n")
      end

      def linter_src
        raise "Must be defined by subclass"
      end

      def files_filter(staged_files)
        staged_files.grep(/\.js$/)
      end

      def error_selector
        'reason'
      end

      def display_error(error_object, file)
        return "" unless error_object

        line = error_object['line'].to_i + 1
        "#{error_object[error_selector]}\n#{file}:#{line} #{error_object['evidence']}"
      end
    end
  end
end
