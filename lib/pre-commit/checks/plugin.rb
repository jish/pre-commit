require 'plugins/pluginator/extensions/conversions'
require 'pre-commit/checks/plugin/config_file'
require 'pre-commit/line'

module PreCommit
  module Checks
    class Plugin
      include Pluginator::Extensions::Conversions

      attr_accessor :pluginator, :config

      def initialize(pluginator, config, list)
        @pluginator = pluginator
        @config     = config
        @list       = list
      end

      def name
        class2string(class2name(self.class))
      end

    private

      def config_file
        @config_file ||= ConfigFile.new(name, config, alternate_config_file)
        @config_file.location
      end

      def alternate_config_file
        ''
      end

      # group files in packs smaller then 127kB (1000 files)
      # 127k based on http://www.in-ulm.de/~mascheck/various/argmax/
      # and 262144 limit on OSX - my env size /2 to be safe
      # assuming mean file length shorter then 127 chars splitting to
      # groups of 1000 files, each_slice for simplicity, doing real
      # check could be to time consuming
      def in_groups(files, group_size = 1000)
        files.each_slice(group_size)
      end

    end
  end
end
