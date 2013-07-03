require 'minitest_helper'
require 'pre-commit/checks/tabs_check'

describe PreCommit::TabsCheck do
  let(:subject) { PreCommit::TabsCheck.new }

  it "detect a tab" do
    check = subject
    check.staged_files = test_filename('tabs.rb')
    assert check.detected_bad_code?, 'should detect tabs'
  end

  it "detects leading whitespace followed by a tab" do
    check = subject
    check.staged_files = test_filename('bad_tabs2.rb')
    assert check.detected_bad_code?, 'should detect leading whitespace followed by tabs'
  end

  it "passes with a valid file" do
    check = subject
    check.staged_files = test_filename('valid_file.rb')
    assert !check.detected_bad_code?, 'should pass valid files'
  end

  it "passes with a binary file with initial tab" do
    check = subject
    check.staged_files = test_filename('property_sets-0.3.0.gem')
    assert check.run, 'A binary file with initial tab'
  end

  it "shows error message when an initial tab is found" do
    check = subject
    def check.detected_bad_code?
      true
    end

    check.staged_files = test_filename('initial_tab.rb')
    assert !check.run, 'We should prevent an initial tab from being committed'

    assert_match(/pre-commit: detected tab before initial space:/, check.error_message)
    assert_match(/initial_tab.rb/, check.error_message)
  end

  it "passes without files" do
    check = subject
    check.staged_files = []
    assert check.run
  end
end
