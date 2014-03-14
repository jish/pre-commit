module PreCommit
  module Checks
    class Plugin
      class ConfigFile
        def initialize(name, config, alternate_location, config_key = 'config')
          @name = name
          @config = config
          @alternate_location = alternate_location
          @config_key = config_key
        end

        def location
          return @location if defined?(@location)

          @location = location_from_config || location_from_alternate
        end

      private
        attr_reader :name, :config, :alternate_location, :config_key

        def location_from_config
          location_from(config_location, true)
        end

        def location_from_alternate
          location_from(alternate_location)
        end

        def location_from(location, show_usage = false)
          if location_present?(location)
            if File.exist?(location)
              location
            else
              usage if show_usage
              nil
            end
          end
        end

        def location_present?(location)
          location && !location.empty?
        end

        def config_location
          @config_location ||= config.get(property_name)
        end

        def property_name
          "#{name}.#{config_key}"
        end

        def environment_variable_name
          "#{name.upcase}_#{config_key.upcase}"
        end

        def yaml_property_name
          property_name.gsub(/_/, '.')
        end

        def usage
          alternate_location_message = "look for #{alternate_location} or " if location_present?(alternate_location)

          $stderr.puts "Warning: #{name} config file '#{config_location}' does not exist"
          $stderr.puts "Set the path to the config file using:"
          $stderr.puts "\tgit config pre-commit.#{property_name} 'path/relative/to/git/dir/#{name}.config'"
          $stderr.puts "Or in 'config/pre-commit.yml':"
          $stderr.puts "\t#{yaml_property_name}: path/relative/to/git/dir/#{name}.config"
          $stderr.puts "Or set the environment variable:"
          $stderr.puts "\texport #{environment_variable_name}='path/relative/to/git/dir/#{name}.config'"
          $stderr.puts "#{name} will #{alternate_location_message}use its default behavior.\n\n"
        end
      end
    end
  end
end
