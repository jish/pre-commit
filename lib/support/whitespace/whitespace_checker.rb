module PreCommit
  class WhiteSpaceChecker
    WHITESPACE_SCRIPT_PATH = File.join(File.dirname(__FILE__), "whitespace")

    def self.check
      system("sh #{WHITESPACE_SCRIPT_PATH}")
    end
  end
end
