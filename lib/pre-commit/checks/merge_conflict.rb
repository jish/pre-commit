class MergeConflict

  attr_accessor :staged_files

  def self.call
    check = new
    check.staged_files = Utils.staged_files('.')
    check.run
  end

  def run
    !system("grep '<<<<<<<' #{staged_files}")
  end

end
