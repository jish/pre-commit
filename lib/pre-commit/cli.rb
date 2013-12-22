require 'fileutils'

module PreCommit

  TemplateNotFound = Class.new(StandardError)

  class Cli

    PRE_COMMIT_HOOK_PATH = '.git/hooks/pre-commit'
    TEMPLATE_DIR = File.expand_path("../support/templates/", __FILE__)

    attr_reader :templates

    def initialize
      @templates = load_templates
    end

    def install(key = nil)
      key ||= "default"
      hook = templates[key.sub(/^--/, "")]

      raise TemplateNotFound.new("Could not find template #{key}") unless hook

      FileUtils.cp(hook, PRE_COMMIT_HOOK_PATH)
      FileUtils.chmod(0755, PRE_COMMIT_HOOK_PATH)
    end

    private

    def load_templates
      pattern = File.join(TEMPLATE_DIR, "*_hook")

      Dir.glob(pattern).inject({}) do |hash, file|
        key = file.match(/\/([^\/]+?)_hook$/)[1]
        hash[key] = file

        hash
      end
    end

  end
end
