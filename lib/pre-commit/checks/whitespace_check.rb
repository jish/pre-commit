module PreCommit
  class WhiteSpaceCheck
    def self.call(_)
      errors = `git diff-index --check --cached head -- 2>&1`
      return if $?.success?

      if errors =~ /fatal: bad revision 'head'/
        errors = `git diff-index --check --cached 4b825dc642cb6eb9a060e54bf8d69288fbee4904 -- 2>&1`
        return if $?.success?
      end

      errors
    end
  end
end
