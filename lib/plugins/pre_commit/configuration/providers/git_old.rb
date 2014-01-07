require 'plugins/pre_commit/configuration/providers/git'

module PreCommit
  class Configuration
    class Providers

      class GitOld < Git

        def self.priority
          11
        end

        def [](name)
          value = super(name)
          if
            name == :checks && value && ! value.kind_of?(Array)
          then
            value = value.chomp.split(/,\s*/).map(&:to_sym) || []
            update(name, value) unless value.empty?
          end
          value
        end

      end

    end
  end
end
