class Utils

  def self.staged_files(*dirs)
    @staged_files ||= {}
    @staged_files[dirs.join(' ')] ||= `git diff --cached --name-only #{dirs.join(' ')} | xargs`.chomp
  end

  def self.new_files(*dirs)
    @new_files ||= {}
    @new_files[dirs.join(' ')] ||= `git status --short #{dirs.join(' ')} | grep ^A | xargs`.chomp.split("A ").join(" ")
  end
  
end
