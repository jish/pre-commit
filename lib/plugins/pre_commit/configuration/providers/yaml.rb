require 'yaml'
require "pre-commit/configuration/top_level"

module PreCommit
  class Configuration
    class Providers

      class Yaml
        include PreCommit::Configuration::TopLevel

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
          @config ||= begin
            config = {}
            config.merge!(read_config(system_file))
            config.merge!(read_config(global_file))
            config.merge!(read_config(local_file))
            config
          end
        end

        def read_config(path)
          content = YAML.load_file(path) if File.exist?(path)
          content || {}
        end

        def save_config(path, content)
          parent = File.expand_path('..', path)
          Dir.mkdir(parent) unless Dir.exist?(parent)
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

      end

    end
  end
end
