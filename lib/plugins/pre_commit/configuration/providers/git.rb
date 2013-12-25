require 'pre-commit/utils/git_conversions'

module PreCommit
  class Configuration
    class Providers

      class Git
        include PreCommit::Utils::GitConversions

        def self.priority
          10
        end

        def [](name)
          git_to_ruby(`git config pre-commit.#{name.to_s.gsub(/_/,".")} 2>/dev/null`)
        end

        def update(name, value)
          `git config pre-commit.#{name.to_s.gsub(/_/,".")} "#{ruby_to_git(value)}" 2>/dev/null`
        end

      end

    end
  end
end
