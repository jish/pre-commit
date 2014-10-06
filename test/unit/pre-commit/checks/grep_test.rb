require 'minitest_helper'
require 'pre-commit/checks/grep'

describe PreCommit::Checks::Grep do
  subject do
    PreCommit::Checks::Grep.new(nil, nil, [])
  end

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "succeeds if nothing changed" do
    ->{ subject.call([fixture_file('file_with_nb_space.rb')]) }.must_raise PreCommit::Checks::Grep::PaternNotSet
  end

  it "succeeds if file has no pattern" do
    subject.instance_variable_set(:@pattern, "other")
    subject.call([fixture_file('file_with_nb_space.rb')]).must_equal nil
  end

  it "fails if file has pattern" do
    subject.instance_variable_set(:@pattern, "test")
    subject.call([fixture_file('file_with_nb_space.rb')]).to_s.must_equal(
      "test/files/file_with_nb_space.rb:1:test"
    )
  end

  it "fails if file has pattern, even if filename has spaces" do
    subject.instance_variable_set(:@pattern, "test")
    subject.call([fixture_file('filename with spaces.rb')]).to_s.must_equal(
      "test/files/filename with spaces.rb:1:test"
    )
  end

  it "adds message to output" do
    subject.instance_variable_set(:@pattern, "test")
    subject.instance_variable_set(:@message, "extra message:")
    subject.call([fixture_file('file_with_nb_space.rb')]).to_s.must_equal("\
extra message:
test/files/file_with_nb_space.rb:1:test")
  end

  it "respects extra_grep" do
    subject.instance_variable_set(:@pattern, "test")
    subject.instance_variable_set(:@extra_grep, %w{-v test})
    subject.call([fixture_file('file_with_nb_space.rb')]).must_equal(nil)
  end

  it "finds grep for FreeBSD" do
    subject.send(:grep, 'FreeBSD').must_equal(%w{grep -EnIH})
  end

  it "finds grep for other systems" do
    subject.send(:grep,  'other systems').must_equal(%w{grep -PnIH})
  end

  it "detects grep version" do
    subject.send(:detect_grep_version).must_match(/grep/)
  end

end
