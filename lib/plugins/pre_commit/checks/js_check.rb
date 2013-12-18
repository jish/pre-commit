require 'pre-commit/utils'
require 'execjs'

module PreCommit::Checks
  class JsCheck
    def self.supports(name)
      name == :js
    end
    def self.call(staged_files)
      staged_files = staged_files.select { |f| File.extname(f) == ".js" }
      return if staged_files.empty?

      errors = []
      staged_files.each do |file|
        error_list = Array(run_check(file))
        error_list.each { |error_object| errors << display_error(error_object, file) }
      end

      return if errors.empty?
      errors.join("\n")
    end

    def self.check_name
      raise "Must be defined by subclass"
    end

    def self.linter_src
      raise "Must be defined by subclass"
    end

    def self.display_error(error_object, file)
      return "" unless error_object

      line = error_object['line'].to_i + 1
      "#{error_object['reason']}\n#{file}:#{line} #{error_object['evidence']}"
    end
  end
end
