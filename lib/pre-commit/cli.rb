require 'fileutils'

module PreCommit
  class Cli

    PRE_COMMIT_HOOK_PATH = '.git/hooks/pre-commit'
    TEMPLATE_DIR = File.expand_path("../support/templates/", __FILE__)
    TEMPLATE_MAP = { "--manual" => "manual" }

    def install(template_key = nil)
      hook = template_file(template_key)
      FileUtils.cp(hook, PRE_COMMIT_HOOK_PATH)
      FileUtils.chmod(0755, PRE_COMMIT_HOOK_PATH)
    end

    def template_file(key)
      template = hook_template(key)
      File.exists?(template) ? template : hook_template("default")
    end

    def hook_template(key)
      template = TEMPLATE_MAP[key] || "pre-commit-hook"
      File.join(TEMPLATE_DIR, template)
    end

  end
end
