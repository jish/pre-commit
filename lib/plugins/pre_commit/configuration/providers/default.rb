module PreCommit
  class CanNotUpdateDefauls < StandardError
  end

  class Configuration
    class Providers
      class Default

        DEFAULTS =
        {
          :warnings => [],
          :checks   => [:common, :rails]
        }

        def self.priority
          0
        end

        def initialize(defaults = nil)
          @defaults = defaults || DEFAULTS
        end

        def [](name)
          @defaults[name]
        end

        def update(name, value)
          raise PreCommit::CanNotUpdateDefauls.new("Can not update default settings")
        end

      end
    end
  end
end
