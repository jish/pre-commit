require 'fileutils'
require 'pre-commit/configuration'

module PreCommit

  class Installer

    TARGET_HOOK_PATH = '.git/hooks/pre-commit'
    TEMPLATE_DIR = File.expand_path("../../../templates/hooks/", __FILE__)

    attr_reader :key

    def initialize(key = nil)
      @key = key || "default"
    end

    def hook
      templates[key.sub(/^--/, "")]
    end

    def target
      TARGET_HOOK_PATH
    end

    def install
      if
        hook
      then
        FileUtils.mkdir_p(File.dirname(target))
        FileUtils.cp(hook, target)
        FileUtils.chmod(0755, target)
        puts "Installed #{hook} to #{target}"
        true
      else
        warn "Could not find template #{key}"
        false
      end
    end

  private

    def templates
      return @templates if @templates
      pattern = File.join(TEMPLATE_DIR, "*")

      @templates =
      Dir.glob(pattern).inject({}) do |hash, file|
        key = file.match(/\/([^\/]+?)$/)[1]
        hash[key] = file
        hash
      end
    end

  end
end
