require "date"
require "erb"
require "fileutils"

module PreCommit
  class Template
    TEMPLATE_DIR = File.expand_path("../../../templates/gem", __FILE__)

    attr_reader :name, :author, :email, :description, :gem_name, :copyright

    def initialize(*args)
      @name, @author, @email, @description = args
      @gem_name    = "pre-commit-#{name}"
      @copyright   = "#{Date.today.year} #{author} #{email}"
      validate_params
    end

    def save
      puts "Generating #{gem_name}"
      all_files.each{|file| parse_and_save(file) }
      initialize_git
      puts <<-STEPS

Next steps:
- write your checks and tests for them
- push code to github
- open a ticket to merge your project: https://github.com/jish/pre-commit/issues
STEPS
    end

    def all_files
      Dir.glob("#{TEMPLATE_DIR}/**/*", File::FNM_DOTMATCH)
        .reject { |path| File.directory?(path) }
    end

    def target_path(file)
      file
        .sub(TEMPLATE_DIR, gem_name)
        .sub("GEM_NAME", gem_name)
        .sub("PLUGIN_NAME", name)
    end

  private

    def validate_params
      raise ArgumentError, "Missing name"               if name.nil?        || name.empty?
      raise ArgumentError, "Missing author"             if author.nil?      || author.empty?
      raise ArgumentError, "Missing email"              if email.nil?       || email.empty?
      raise ArgumentError, "Missing description"        if description.nil? || description.empty?
      raise ArgumentError, "#{gem_name} already exists" if File.directory?(gem_name)
    end

    def parse_and_save(file)
      save_file(
        target_path(file),
        parse_template(file),
      )
    end

    def save_file(path, content)
      FileUtils.mkdir_p(File.expand_path("..", path))
      File.write(path, content, 0, mode: "w")
    end

    def parse_template(path)
      ERB.new(
        File.read(path)
      ).result(
        binding
      )
    end

    def initialize_git
      return if `which git 2>/dev/null`.empty?

      Dir.chdir gem_name do
        puts `git init`
        puts `git add .`
        puts `git commit -m "created #{gem_name}"`
      end
    end
  end
end
