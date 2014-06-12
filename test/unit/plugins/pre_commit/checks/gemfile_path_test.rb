require 'minitest_helper'
require 'plugins/pre_commit/checks/gemfile_path'

describe PreCommit::Checks::GemfilePath do
  let(:check){ PreCommit::Checks::GemfilePath.new(nil, nil, []) }

  before do
    create_temp_dir
    start_git
  end
  after(&:destroy_temp_dir)

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds if non-gemfile changes" do
    write "Foofile", <<-RUBY
      gem "foo", :path => "xxx"
    RUBY
    check.call(["Foofile"]).must_equal nil
  end

  it "succeeds if only good changes" do
    write "Gemfile", <<-RUBY
      gem "foo"
    RUBY
    check.call(["Gemfile"]).must_equal nil
  end

  it "succeeds with innocent path check" do
    write "Gemfile", <<-RUBY
      gem "foo_path"
    RUBY
    check.call(["Gemfile"]).must_equal nil
  end

  it "fails if Gemfile contains path =>" do
    write "Gemfile", <<-RUBY
      gem "foo", :path => "xxxx"
    RUBY
    check.call(["Gemfile"]).must_equal(<<-EXPECTED)
local path found in Gemfile:
Gemfile:1:      gem "foo", :path => "xxxx"
EXPECTED
  end

  it "fails if Gemfile contains path:" do
    write "Gemfile", <<-RUBY
      gem "foo", path: "xxxx"
    RUBY
    check.call(["Gemfile"]).must_equal(<<-EXPECTED)
local path found in Gemfile:
Gemfile:1:      gem "foo", path: "xxxx"
EXPECTED
  end

  it "allows a Gemfile path that is commented out" do
    write "Gemfile", <<-RUBY
      # gem 'my-internal-app-gem', '~> 0.0.1', :path => './lib/my-internal-app-gem'
    RUBY
    check.call(["Gemfile"]).must_equal nil, "There should be no errors"
  end

end
