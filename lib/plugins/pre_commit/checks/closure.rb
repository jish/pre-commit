module PreCommit::Checks
  class Closure
    #TODO: add pluginator assets support
    CLOSURE_PATH = File.expand_path("../../../../pre-commit/support/closure/compiler.jar", __FILE__)

    def self.supports(name)
      name == :closure_syntax_check
    end
    def self.call(staged_files)
      return if staged_files.empty?
      js_args = staged_files.map {|arg| "--js #{arg}"}.join(' ')
      errors = `java -jar #{CLOSURE_PATH} #{js_args} --js_output_file /tmp/jammit.js 2>&1`.strip
      return if errors.empty?
      errors
    end
  end
end
