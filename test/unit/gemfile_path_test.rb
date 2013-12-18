require 'minitest_helper'
require 'plugins/pre_commit/checks/gemfile_path'

describe PreCommit::Checks::GemfilePath do
  let(:check){ PreCommit::Checks::GemfilePath }

  in_temp_dir

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
    check.call(["Gemfile"]).must_equal "local path found in Gemfile:\nGemfile:1:      gem \"foo\", :path => \"xxxx\""
  end

  it "fails if Gemfile contains path:" do
    write "Gemfile", <<-RUBY
      gem "foo", path: "xxxx"
    RUBY
    check.call(["Gemfile"]).must_equal "local path found in Gemfile:\nGemfile:1:      gem \"foo\", path: \"xxxx\""
  end
end
