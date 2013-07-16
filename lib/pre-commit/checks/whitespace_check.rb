module PreCommit
  class WhiteSpaceCheck
    def self.call(_)
      errors = `git diff-index --check --cached head --`
      return if $?.success?
      errors
    end
  end
end
