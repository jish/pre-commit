require 'pre-commit/checks/base_check'

module PreCommit
  class ClosureCheck < BaseCheck
    CLOSURE_PATH = File.expand_path("../../../support/closure/compiler.jar", __FILE__)

    def self.run(staged_files)
      return if staged_files.empty?
      js_args = staged_files.map {|arg| "--js #{arg}"}.join(' ')
      errors = `java -jar #{CLOSURE_PATH} #{js_args} --js_output_file /tmp/jammit.js 2>&1`.strip
      return if errors.empty?
      errors
    end
  end
end
