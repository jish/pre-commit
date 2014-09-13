module PreCommit
  class Line < Struct.new :message, :file, :line, :code

    def to_s
      result = message.to_s
      unless empty? file
        result = "#{result}#{"\n" unless empty?(result)}#{file}"
        result = "#{result}:#{line}" unless empty? line
        result = "#{result}:#{code}" unless empty? code
      end
      result
    end

  protected

    def empty?(string)
      string == nil || string == ""
    end

  end
end

