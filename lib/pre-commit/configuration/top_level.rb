module PreCommit
  class Configuration
    module TopLevel
      def top_level
        top_level = `git rev-parse --show-toplevel`.chomp.strip
        raise "no git repo!" if top_level == ""
        top_level
      end
    end
  end
end
