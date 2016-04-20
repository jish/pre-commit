class ShortCircuitFile
  def blam
    if true && something
      puts 'this will always print'
    end

    if false && something
      puts 'this will never print'
    end
  end
end
