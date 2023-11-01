class ShortCircuitFile
  def blam
    if false && something
      puts 'this will never print'
    end

    if true || something
      puts 'this will always print'
    end

    # These are daft but ok
    if false || something
      puts 'daft but valid'
    end

    if true && something
      puts 'daft but valid'
    end

    if true
      puts "this will always print"
    end

  end
end
