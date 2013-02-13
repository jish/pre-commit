require 'pre-commit/utils'

module PreCommit
  class LocalCheck

    DEFAULT_LOCATION = "config/pre-commit.rb"
    attr_accessor :error_message

    def self.call(quiet=false)
      check = new
      result = check.run(DEFAULT_LOCATION, Utils.staged_files("."))
      puts check.error_message if !result && !quiet
      result
    end

    def run(file, staged_files)
      return true unless File.exist?(file)
      output = `ruby #{file} #{staged_files} 2>&1`
      if $?.success?
        true
      else
        self.error_message = "#{file} failed:\n#{output}"
        false
      end
    end

  end
end
