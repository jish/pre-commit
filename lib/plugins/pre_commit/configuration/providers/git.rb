require 'pre-commit/utils/string_to_ruby'

module PreCommit
  class Configuration
    class Providers

      class Git
        include PreCommit::Utils::StringToRuby

        def self.priority
          10
        end

        def [](name)
          string_to_ruby(`git config pre-commit.#{name.to_s.gsub(/_/,".")} 2>/dev/null`)
        end
      end

    end
  end
end
