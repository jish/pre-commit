require 'pre-commit/base'
require 'pre-commit/utils'

class PreCommit
  class JshintCheck

    attr_accessor :therubyracer_installed

    def initialize
      @therubyracer_installed = ruby_racer_installed?
    end

    def call
      js_files = reject_non_js(load_staged_files)

      if should_run?(js_files)
        run(js_files)
      else
        $stderr.puts 'pre-commit: Skipping JSHint check (to run it: `gem install therubyracer`)' if !ruby_racer_installed?
        # pretend the check passed and move on
        true
      end
    end

    def run(js_files)
      errors = []

      js_files.each do |file|
        V8::Context.new do |context|
          context.load(jshint_src)
          context['source'] = lambda { File.read(file) }
          context['report'] = lambda do |array|
            array.each { |error_object| errors << display_error(error_object, file) }
          end

          context.eval('var result = JSHINT(source());')
          context.eval('report(JSHINT.errors);')
        end
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
      ruby_racer_installed? && js_files.any?
    end

    def ruby_racer_installed?
      if instance_variable_defined?(:@therubyracer_installed)
        @therubyracer_installed
      else
        begin
          require 'v8'
          @therubyracer_installed = true
        rescue LoadError
          @therubyracer_installed = false
        end
      end
    end

    def jshint_src
      File.join(PreCommit.root, 'lib', 'support', 'jshint', 'jshint.js')
    end

    def load_staged_files
      Utils.staged_files('.').split(" ")
    end

    def reject_non_js(staged_files)
      staged_files.select { |f| f =~ /\.js$/ }
    end

    def display_error(error_object, file)
      line = error_object['line'].to_i + 1
      "pre-commit: JSHINT #{error_object['reason']}\n#{file}:#{line} #{error_object['evidence']}"
    end

  end
end
