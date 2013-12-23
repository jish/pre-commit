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

        def config
          return Hash.new unless File.exist?(file_name)
          @config ||= YAML.load_file(file_name) || Hash.new
        end

        def file_name
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
