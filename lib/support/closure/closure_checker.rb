module PreCommit
  class ClosureChecker
    CLOSURE_PATH = File.join(File.dirname(__FILE__),"compiler.jar")

    def self.check(files)
      js_args = files.map {|arg| "--js #{arg}"}.join(' ')
      system("java -jar #{CLOSURE_PATH} #{js_args} --js_output_file /tmp/jammit.js")
    end
  end
end
