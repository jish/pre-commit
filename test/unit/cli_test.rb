require 'minitest_helper'
require 'pre-commit/cli'

describe PreCommit::Cli do

  in_temp_dir do
    FileUtils.mkdir_p(".git/hooks")
  end

  let(:cli) { PreCommit::Cli.new }
  let(:hook) { PreCommit::Cli::PRE_COMMIT_HOOK_PATH }

  it "intalls the hook" do
    File.exists?(hook).must_equal false
    cli.install
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.hook_template("default"))
  end

  it "installs other hook templates" do
    File.exists?(hook).must_equal false
    cli.install("--manual")
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.hook_template("--manual"))
  end

  it "installs the default hook when passed --automatic" do
    File.exists?(hook).must_equal false
    cli.install("--automatic")
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.hook_template("default"))
  end

end
