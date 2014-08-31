# encoding: utf-8

# class docs for rubocop
class ValidFile
  # Comments with the word: debugger should be allowed
  def no_problems_here!
  end

  # Need a safe version of method! to avoid PrimaDonnaMethod code smell in reek
  def no_problems_here
  end
end
