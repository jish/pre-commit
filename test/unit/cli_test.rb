require 'minitest_helper'
require 'pre-commit/cli'

describe PreCommit::Cli do

  before do
    create_temp_dir
    FileUtils.mkdir_p(".git/hooks")
  end
  after(&:destroy_temp_dir)

  let(:cli) { PreCommit::Cli.new }
  let(:hook) { PreCommit::Cli::PRE_COMMIT_HOOK_PATH }

  it "intalls the hook" do
    File.exists?(hook).must_equal false
    cli.install
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.templates["default"])
  end

  it "installs other hook templates" do
    File.exists?(hook).must_equal false
    cli.install("--manual")
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.templates["manual"])
  end

  it "installs the default hook when passed --automatic" do
    File.exists?(hook).must_equal false
    cli.install("--automatic")
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.templates["default"])
  end

  it "handles missing templates" do
    File.exists?(hook).must_equal false
    -> { cli.install("--not-found") }.must_raise(PreCommit::TemplateNotFound)
  end

end
