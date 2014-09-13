module PreCommit
  class Message < Struct.new :message, :lines

    def to_s
      result = message
      result = "#{message}\n#{lines.map(&:to_s).join("\n")}" unless lines.nil?
      result
    end

  protected

    def empty?(string)
      string == nil || string == ""
    end

  end
end
