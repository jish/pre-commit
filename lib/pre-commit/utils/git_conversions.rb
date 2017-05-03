module PreCommit
  module Utils
    module GitConversions

    # git_to_ruby related

      def git_to_ruby(value)
        value = value.chomp.strip if String === value
        case value
        when /\A\[(.*)\]\Z/
          str2arr($1)
        when ''
          nil
        when String
          str_symbolize(value)
        else
          value
        end
      end

      def str2arr(string)
        string.split(/, ?/).map{|s| str_symbolize(s.chomp.strip) }
      end

      def str_symbolize(string)
        if string =~ /\A:(.*)\Z/
        then $1.to_sym
        else string
        end
      end

    # ruby_to_git related

      def ruby_to_git(value)
        case value
        when Array
          arr2str(value)
        else
          sym_symbolize(value)
        end
      end

      def arr2str(value)
        "[#{value.map{|v| sym_symbolize(v) }.join(", ")}]"
      end

      def sym_symbolize(value)
        if Symbol === value
        then ":#{value}"
        else value.to_s
        end
      end

    end
  end
end
