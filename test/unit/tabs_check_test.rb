require 'minitest_helper'
require 'pre-commit/checks/tabs_check'

describe PreCommit::TabsCheck do
  let(:check) { PreCommit::TabsCheck }

  it "passes without files" do
    check.run([]).must_equal nil
  end

  it "detect a tab" do
    check.run([test_filename('tabs.rb')]).wont_equal nil
  end

  it "detects leading whitespace followed by a tab" do
    check.run([test_filename('bad_tabs2.rb')]).wont_equal nil
  end

  it "passes with a valid file" do
    check.run([test_filename('valid_file.rb')]).must_equal nil
  end

  it "passes with a binary file with initial tab" do
    check.run([test_filename('property_sets-0.3.0.gem')]).must_equal nil
  end

  it "shows error message when an initial tab is found" do
    check.run([test_filename('initial_tab.rb')]).must_equal "detected tab before initial space:\ntest/files/initial_tab.rb:3:\t 'hello'"
  end
end
