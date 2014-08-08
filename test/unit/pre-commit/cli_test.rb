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

  it "shows fallbacks to help" do
    cli = subject.new('unknown')
    cli.execute.must_equal(false)
    $stderr.string.must_match(/Usage:/)
    $stdout.string.must_equal('')
  end

  it "intalls the hook" do
    cli = subject.new('install')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*\/templates\/hooks\/default to .*\n/)
  end

  it "lists configuration" do
    cli = subject.new('list')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0) git(10) git_old(11) yaml(20) env(30)
Available checks   : before_all ci closure coffeelint common console_log csslint debugger gemfile_path go go_build go_fmt jshint jslint json local merge_conflict migration nb_space php pry rails rspec_focus rubocop ruby ruby_symbol_hashrockets scss_lint tabs whitespace yaml
Default   checks   : common rails
Enabled   checks   : common rails
Evaluated checks   : tabs nb_space whitespace merge_conflict debugger pry local jshint console_log migration
Default   warnings :
Enabled   warnings :
Evaluated warnings :
EXPECTED
  end

  it "lists plugins" do
    cli = subject.new('plugins')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    cli.list_evaluator.send(:plugin_names).each {|name|
      $stdout.string.must_match("#{name} : ")
    }
  end

  it "disable checks" do
    cli = subject.new('disable', 'git', 'checks', 'whitespace')
    status = cli.execute
    $stderr.string.must_equal('')
    $stdout.string.must_equal('')
    status.must_equal(true)
    sh("git config pre-commit.checks.remove").strip.must_equal("[:whitespace]")
    cli = subject.new('list')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0) git(10) git_old(11) yaml(20) env(30)
Available checks   : before_all ci closure coffeelint common console_log csslint debugger gemfile_path go go_build go_fmt jshint jslint json local merge_conflict migration nb_space php pry rails rspec_focus rubocop ruby ruby_symbol_hashrockets scss_lint tabs whitespace yaml
Default   checks   : common rails
Enabled   checks   : common rails
Evaluated checks   : tabs nb_space merge_conflict debugger pry local jshint console_log migration
Default   warnings :
Enabled   warnings :
Evaluated warnings :
EXPECTED
  end

  it "disable checks by alias" do
    cli = subject.new('disable', 'git', 'checks', 'whitespace')
    status = cli.execute
    $stderr.string.must_equal('')
    $stdout.string.must_equal('')
    status.must_equal(true)
    sh("git config pre-commit.checks.remove").strip.must_equal("[:whitespace]")
    cli = subject.new('list')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0) git(10) git_old(11) yaml(20) env(30)
Available checks   : before_all ci closure coffeelint common console_log csslint debugger gemfile_path go go_build go_fmt jshint jslint json local merge_conflict migration nb_space php pry rails rspec_focus rubocop ruby ruby_symbol_hashrockets scss_lint tabs whitespace yaml
Default   checks   : common rails
Enabled   checks   : common rails
Evaluated checks   : tabs nb_space merge_conflict debugger pry local jshint console_log migration
Default   warnings :
Enabled   warnings :
Evaluated warnings :
EXPECTED
  end

  it "enables warnings" do
    cli = subject.new('enable', 'git', 'warnings', 'gemfile_path')
    status = cli.execute
    $stderr.string.must_equal('')
    $stdout.string.must_equal('')
    status.must_equal(true)
    sh("git config pre-commit.warnings.add").strip.must_equal("[:gemfile_path]")
    cli = subject.new('list')
    cli.execute.must_equal(true)
    $stderr.string.must_equal('')
    $stdout.string.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0) git(10) git_old(11) yaml(20) env(30)
Available checks   : before_all ci closure coffeelint common console_log csslint debugger gemfile_path go go_build go_fmt jshint jslint json local merge_conflict migration nb_space php pry rails rspec_focus rubocop ruby ruby_symbol_hashrockets scss_lint tabs whitespace yaml
Default   checks   : common rails
Enabled   checks   : common rails
Evaluated checks   : tabs nb_space whitespace merge_conflict debugger pry local jshint console_log migration
Default   warnings :
Enabled   warnings : gemfile_path
Evaluated warnings : gemfile_path
EXPECTED
  end

  it "does fail on unknown provider" do
    cli = subject.new('enable', 'unknown', 'warnings', 'gemfile_path')
    status = cli.execute
    $stderr.string.must_equal(<<-EXPECTED)
Plugin not found for unknown.
EXPECTED
    $stdout.string.must_equal('')
    status.must_equal(false)
  end

  it "shows help on missing enable params" do
    cli = subject.new('enable')
    status = cli.execute
    $stderr.string.must_equal(<<-EXPECTED)
Unknown parameters: enable
Usage: pre-commit install
Usage: pre-commit list
Usage: pre-commit plugins
Usage: pre-commit <enable|disable> <git|yaml> <checks|warnings> check1 [check2...]
EXPECTED
    $stdout.string.must_equal('')
    status.must_equal(false)
  end

  it "shows help on missing enable git params" do
    cli = subject.new('enable', 'git')
    status = cli.execute
    $stderr.string.must_equal(<<-EXPECTED)
Unknown parameters: enable git
Usage: pre-commit install
Usage: pre-commit list
Usage: pre-commit plugins
Usage: pre-commit <enable|disable> <git|yaml> <checks|warnings> check1 [check2...]
EXPECTED
    $stdout.string.must_equal('')
    status.must_equal(false)
  end

  it "shows help on missing enable git checks params" do
    cli = subject.new('enable', 'git', 'checks')
    status = cli.execute
    $stderr.string.must_equal(<<-EXPECTED)
Unknown parameters: enable git checks
Usage: pre-commit install
Usage: pre-commit list
Usage: pre-commit plugins
Usage: pre-commit <enable|disable> <git|yaml> <checks|warnings> check1 [check2...]
EXPECTED
    $stdout.string.must_equal('')
    status.must_equal(false)
  end

  it "shows help on missing disable params" do
    cli = subject.new('disable')
    status = cli.execute
    $stderr.string.must_equal(<<-EXPECTED)
Unknown parameters: disable
Usage: pre-commit install
Usage: pre-commit list
Usage: pre-commit plugins
Usage: pre-commit <enable|disable> <git|yaml> <checks|warnings> check1 [check2...]
EXPECTED
    $stdout.string.must_equal('')
    status.must_equal(false)
  end

end
