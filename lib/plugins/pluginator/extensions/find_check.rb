require "plugins/pluginator/extensions/conversions"

module Pluginator::Extensions
  # Extension to find class or first plugin that answers the question with true or to print warning
  module FindCheck
    include Conversions

    def find_check(name)
      klass = string2class(name)
      @plugins["checks"].detect do |plugin|
        plugin.name.split('::').last == klass ||
        plugin.respond_to?(:suports) && plugin.public_send(:suports, name)
      end ||
      begin
        $stderr.puts "Could not find plugin supporting #{name}."
        nil
      end
    end

  end
end
