require 'minitest_helper'
require 'pre-commit/template'

describe PreCommit::Template do

  subject do
    PreCommit::Template.new("plugin-name",
      "Author Name",
      "author.email@example.com",
      "Plugin description.")
  end

  it "gathers a list of files" do
    assert_equal(12, subject.all_files.length)
  end

  it "substitutes in the plugin name in the file list" do
    processed_filenames = subject.all_files.map do |file|
      subject.target_path(file)
    end

    [
      "pre-commit-plugin-name/.gitignore",
      "pre-commit-plugin-name/.travis.yml",
      "pre-commit-plugin-name/pre-commit-plugin-name.gemspec",
      "pre-commit-plugin-name/Gemfile",
      "pre-commit-plugin-name/lib/plugins/pre_commit/checks/plugin-name.rb",
      "pre-commit-plugin-name/lib/pre-commit/plugin-name/version.rb",
      "pre-commit-plugin-name/LICENSE",
      "pre-commit-plugin-name/Rakefile",
      "pre-commit-plugin-name/README.md",
      "pre-commit-plugin-name/test/files/.keep",
      "pre-commit-plugin-name/test/minitest_helper.rb",
      "pre-commit-plugin-name/test/plugins/pre_commit/checks/plugin-name_test.rb"
    ].sort.each_with_index do |expected, index|
      assert_equal(expected, processed_filenames[index])
    end

  end

end
