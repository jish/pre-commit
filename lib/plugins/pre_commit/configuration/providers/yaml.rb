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

      private

        def config
          return @config if @config
          @config = {}
          read_config(system_file)
          read_config(global_file)
          read_config(local_file)
          @config
        end

        def read_config(path)
          content = YAML.load_file(path) if File.exist?(path)
          @config.merge!(content) if content
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
