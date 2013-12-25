require 'yaml'

module PreCommit
  class Configuration
    class Providers

      class Yaml
        def self.priority
          20
        end

        def [](name)
          config[name]
        end

        def update(name, value)
          content = read_config(local_file)
          content[name] = value
          save_config(local_file, content)
        end

      private

        def config
          return @config if @config
          @config = {}
          @config.merge!(read_config(system_file))
          @config.merge!(read_config(global_file))
          @config.merge!(read_config(local_file))
          @config
        end

        def read_config(path)
          content = YAML.load_file(path) if File.exist?(path)
          content || {}
        end

        def save_config(path, content)
          File.open(path, "w") do |file|
            file.write(YAML.dump(content))
          end
        end

        def system_file
          @system_file ||= '/etc/pre_commit.yml'
        end

        def global_file
          @global_file ||= File.join(ENV['HOME'], '.pre_commit.yml')
        end

        def local_file
          File.join(top_level, 'config', 'pre_commit.yml')
        end

        def top_level
          top_level = `git rev-parse --show-toplevel`.chomp.strip
          raise "no git repo!" if top_level == ""
          top_level
        end
      end

    end
  end
end
