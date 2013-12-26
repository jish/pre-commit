require 'minitest_helper'
require 'pre-commit/installer'
require 'stringio'

describe PreCommit::Installer do

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

  subject { PreCommit::Installer }

  it "intalls the hook" do
    installer = subject.new
    File.exists?(installer.target).must_equal false
    installer.install.must_equal(true)
    File.exists?(installer.target).must_equal true
    File.read(installer.target).must_equal File.read(installer.send(:templates)["default"])
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*\/templates\/hooks\/default to #{installer.target}\n/)
  end

  it "installs other hook templates" do
    installer = subject.new('--manual')
    File.exists?(installer.target).must_equal false
    installer.install.must_equal(true)
    File.exists?(installer.target).must_equal true
    File.read(installer.target).must_equal File.read(installer.send(:templates)["manual"])
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*\/templates\/hooks\/manual to #{installer.target}\n/)
  end

  it "installs the default hook when passed --automatic" do
    installer = subject.new('--automatic')
    File.exists?(installer.target).must_equal false
    installer.install.must_equal(true)
    File.exists?(installer.target).must_equal true
    File.read(installer.target).must_equal File.read(installer.send(:templates)["default"])
    $stderr.string.must_equal('')
    $stdout.string.must_match(/Installed .*\/templates\/hooks\/automatic to #{installer.target}\n/)
  end

  it "handles missing templates" do
    installer = subject.new('--not-found')
    File.exists?(installer.target).must_equal false
    installer.install.must_equal(false)
    $stderr.string.must_match(/Could not find template/)
    $stdout.string.must_equal('')
  end

end
