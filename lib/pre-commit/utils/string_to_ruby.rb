module PreCommit
  class Utils
    module StringToRuby

      def string_to_ruby(value)
        value = value.chomp.strip if String === value
        case value
        when /\A\[(.*)\]\Z/
          str2arr($1)
        when ''
          nil
        when String
          symbolize(value)
        else
          value
        end
      end

      def str2arr(string)
        string.split(/, ?/).map{|string| symbolize(string.chomp.strip) }
      end

      def symbolize(string)
        if string =~ /\A:(.*)\Z/
        then $1.to_sym
        else string
        end
      end

    end
  end
end
