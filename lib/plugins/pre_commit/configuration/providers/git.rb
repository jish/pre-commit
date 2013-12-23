module PreCommit
  class Configuration
    class Providers

      class Git
        def self.priority
          10
        end

        def [](name)
          value = `git config pre-commit.#{name} 2>/dev/null`.chomp.strip
          value = nil if value == ''
          value
        end
      end

    end
  end
end
