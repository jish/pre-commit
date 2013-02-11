require 'pre-commit/base'
require 'pre-commit/utils'
require 'execjs'

module PreCommit
  class JsCheck

    def call
      js_files = reject_non_js(files_to_check)
      if should_run?(js_files)
        run(js_files)
      else
        # pretend the check passed and move on
        true
      end
    end

    def run(js_files)
      errors = []

      js_files.each do |file|
        error_list = Array(run_check(file))
        error_list.each { |error_object| errors << display_error(error_object, file) }
      end

      if errors.empty?
        true
      else
        $stderr.puts errors.join("\n")
        $stderr.puts
        $stderr.puts 'pre-commit: You can bypass this check using `git commit -n`'
        $stderr.puts
        false
      end
    end

    def should_run?(js_files)
      js_files.any?
    end

    def reject_non_js(staged_files)
      staged_files.select { |f| f =~ /\.js$/ }
    end

    def check_name
      raise "Must be defined by subclass"
    end

    def linter_src
      raise "Must be defined by subclass"
    end

    def display_error(error_object, file)
      return "" unless error_object

      line = error_object['line'].to_i + 1
      "pre-commit: #{check_name.upcase} #{error_object['reason']}\n#{file}:#{line} #{error_object['evidence']}"
    end

  end
end
