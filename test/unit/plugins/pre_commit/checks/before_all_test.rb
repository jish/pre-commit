require 'minitest_helper'
require 'plugins/pre_commit/checks/before_all'

describe PreCommit::Checks::BeforeAll do
  subject { PreCommit::Checks::BeforeAll.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    subject.call([]).must_equal nil
  end

  it "filters out rb files" do
    subject.files_filter([
      fixture_file('valid_file.rb'),fixture_file('changelog.md'),fixture_file('console_log.rb')
    ]).must_equal([
      fixture_file('valid_file.rb'),fixture_file('console_log.rb')
    ])
  end

  it "succeeds if only good changes" do
    subject.call([fixture_file('valid_spec.rb')]).must_equal nil
  end

  it "fails if file contains before(:all)" do
    subject.call([fixture_file('before_all_spec.rb')]).must_equal(<<-EXPECTED)
before(:all) found:
test/files/before_all_spec.rb:2:  before(:all) do
EXPECTED
  end

  it "fails if file contains before :all" do
    subject.call([fixture_file('before_all_spec_2.rb')]).must_equal(<<-EXPECTED)
before(:all) found:
test/files/before_all_spec_2.rb:2:  before :all do
EXPECTED
  end
end
