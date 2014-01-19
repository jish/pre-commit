require 'minitest_helper'
require 'plugins/pre_commit/checks/tabs'

describe PreCommit::Checks::Tabs do
  let(:check) { PreCommit::Checks::Tabs.new(nil, nil, []) }

  it "passes without files" do
    check.call([]).must_equal nil
  end

  it "detect a tab" do
    check.call([test_filename('tabs.rb')]).wont_equal nil
  end

  it "detects leading whitespace followed by a tab" do
    check.call([test_filename('bad_tabs2.rb')]).wont_equal nil
  end

  it "passes with a valid file" do
    check.call([test_filename('valid_file.rb')]).must_equal nil
  end

  it "passes with a binary file with initial tab" do
    check.call([test_filename('property_sets-0.3.0.gem')]).must_equal nil
  end

  it "shows error message when an initial tab is found" do
    check.call([test_filename('initial_tab.rb')]).must_equal(<<-EXPECTED)
detected tab before initial space:
test/files/initial_tab.rb:3:\t 'hello'
EXPECTED
  end
end
