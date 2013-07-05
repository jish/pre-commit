module PreCommit
  class WhiteSpaceCheck
    WHITESPACE_SCRIPT_PATH = File.expand_path("../../support/whitespace/whitespace", __FILE__)

    def self.call(_)
      errors = `sh #{WHITESPACE_SCRIPT_PATH}`
      return if $?.success?
      errors
    end
  end
end
