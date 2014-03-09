module PreCommit
  class Configuration
    class Providers

      class Env
        def self.priority
          30
        end

        def [](name)
          ENV[key(name)]
        end

        def update(name, value)
          ENV[key(name)] = value
        end

      private

        def key(name)
          name.to_s.upcase.split('.').join('_')
        end
      end
    end
  end
end
