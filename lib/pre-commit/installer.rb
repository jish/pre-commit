require 'fileutils'
require 'pre-commit/configuration'

module PreCommit
  class Installer

    TARGET_GIT_PATH = '.git'
    TARGET_HOOKS_PATH = 'hooks/pre-commit'
    TEMPLATE_DIR = File.expand_path("../../../templates/hooks/", __FILE__)

    attr_reader :key

    def initialize(key = nil)
      @key = key || "automatic"
    end

    def hook
      templates[key.sub(/^--/, "")]
    end

    def target
      target_git_path =
      if   File.directory?(TARGET_GIT_PATH)
      then TARGET_GIT_PATH
      else File.readlines('.git').first.match(/gitdir: (.*)$/)[1]
      end
      File.join(target_git_path, TARGET_HOOKS_PATH)
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

    def templates
      @templates ||= begin
        pattern = File.join(TEMPLATE_DIR, "*")

        Dir.glob(pattern).inject({}) do |hash, file|
          key = file.match(/\/([^\/]+?)$/)[1]
          hash[key] = file
          hash
        end
      end
    end

  end
end
