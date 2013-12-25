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

  it "shows help" do
    cli = subject.new('help')
    cli.execute.must_equal(true)
    $stderr.string.must_match(/Usage:/)
    $stdout.string.must_equal('')
  end

  it "lists configuration" do
    cli = subject.new('list')
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
    cli = subject.new('install')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*lib\/pre-commit\/support\/templates\/default_hook to .*\n/)
  end

end
