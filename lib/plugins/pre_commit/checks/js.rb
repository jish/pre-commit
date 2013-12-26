require 'pre-commit/utils'

module PreCommit
  module Checks
    class Js
      def self.call(staged_files)
        require 'execjs'
      rescue RuntimeError, LoadError => e
        $stderr.puts "Could not load execjs: #{e}"
      else
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
end
