require 'minitest_helper'
require 'pre-commit/cli'
require 'stringio'

describe PreCommit::Cli do

  before do
    create_temp_dir
    start_git
    FileUtils.mkdir_p(".git/hooks")
    $stderr = StringIO.new
    $stdout = StringIO.new
  end
  after do
    destroy_temp_dir
    $stderr = STDERR
    $stdout = STDOUT
  end

  subject { PreCommit::Cli }
  let(:hook) { PreCommit::Cli::PRE_COMMIT_HOOK_PATH }

  it "shows help" do
    cli = subject.new('help')
    cli.execute.must_equal(true)
    $stderr.string.must_match(/Usage:/)
    $stdout.string.must_equal('')
  end

  it "shows configuration" do
    cli = subject.new('show')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Default checks: white_space console_log debugger pry tabs jshint migrations merge_conflict local nb_space
Enabled checks: white_space console_log debugger pry tabs jshint migrations merge_conflict local nb_space
Default warnings:
Enabled warnings:
EXPECTED
  end

  it "intalls the hook" do
    File.exists?(hook).must_equal false
    cli = subject.new('install')
    cli.execute.must_equal(true)
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.send(:templates)["default"])
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*lib\/pre-commit\/support\/templates\/default_hook to #{hook}\n/)
  end

  it "installs other hook templates" do
    File.exists?(hook).must_equal false
    cli = subject.new('install', '--manual')
    cli.execute.must_equal(true)
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.send(:templates)["manual"])
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*lib\/pre-commit\/support\/templates\/manual_hook to #{hook}\n/)
  end

  it "installs the default hook when passed --automatic" do
    File.exists?(hook).must_equal false
    cli = subject.new('install', '--automatic')
    cli.execute.must_equal(true)
    File.exists?(hook).must_equal true
    File.read(hook).must_equal File.read(cli.send(:templates)["default"])
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*lib\/pre-commit\/support\/templates\/automatic_hook to #{hook}\n/)
  end

  it "handles missing templates" do
    File.exists?(hook).must_equal false
    subject.new('install', '--not-found').execute.must_equal(false)
    $stderr.string.must_match(/Could not find template/)
    $stdout.string.must_equal('')
  end

end
