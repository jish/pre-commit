require 'minitest_helper'
require 'plugins/pre_commit/checks/rspec_focus'

describe PreCommit::Checks::RspecFocus do
  let(:check){ PreCommit::Checks::RspecFocus.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds on non-specs" do
    check.call([fixture_file('bad-spec.rb')]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('rspec_focus_good_spec.rb')]).must_equal nil
  end

  it "succeeds when there are keywords in the description" do
    check.call([fixture_file('rspec_focus_sugar_good_spec.rb')]).must_equal nil
  end

  it 'fails if focus specified on describe, context or example block using any valid syntax' do
    check.call([fixture_file('rspec_focus_bad_spec.rb')]).to_s.must_equal("\
focus found in specs:
test/files/rspec_focus_bad_spec.rb:2:  context 'with old hash syntax', :focus => true do
test/files/rspec_focus_bad_spec.rb:3:    describe 'focus on describe', :focus => true do
test/files/rspec_focus_bad_spec.rb:4:      it 'alerts with focus on example too', :focus => true do
test/files/rspec_focus_bad_spec.rb:9:  context 'with new hash syntax', focus: true do
test/files/rspec_focus_bad_spec.rb:10:    describe 'focus on describe', focus: true do
test/files/rspec_focus_bad_spec.rb:11:      it 'alerts with focus on example too', focus: true do
test/files/rspec_focus_bad_spec.rb:16:  context 'with symbols as keys', :focus do
test/files/rspec_focus_bad_spec.rb:17:    describe 'focus on describe', :focus do
test/files/rspec_focus_bad_spec.rb:18:      it 'alerts with focus on example too', :focus do")
  end

  it 'fails if focus specified on describe, context or example block using any valid syntax' do
    check.call([fixture_file('rspec_focus_sugar_bad_spec.rb')]).to_s.must_equal("\
focus found in specs:
test/files/rspec_focus_sugar_bad_spec.rb:2:  fcontext 'f prefixed to context' do
test/files/rspec_focus_sugar_bad_spec.rb:3:    fdescribe 'f prefixed to describe' do
test/files/rspec_focus_sugar_bad_spec.rb:4:      fit 'f prefixed to it' do")
  end

end
