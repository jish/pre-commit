class ConsoleLog

  attr_accessor :staged_files

  def run
    !system("grep 'console.log' #{staged_files}")
  end

end
