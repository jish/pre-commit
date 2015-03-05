require 'minitest_helper'
require 'plugins/pre_commit/checks/rspec_focus_sugar'


describe PreCommit::Checks::RspecFocusSugar do
  let(:check){ PreCommit::Checks::RspecFocusSugar.new(nil, nil, []) }

  it "succeeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds on non-specs" do
    check.call([fixture_file('bad-spec.rb')]).must_equal nil
  end

  it "succeeds if only good changes" do
    check.call([fixture_file('rspec_focus_sugar_good_spec.rb')]).must_equal nil
  end

  it 'fails if focus specified on describe, context or example block using any valid syntax' do
    check.call([fixture_file('rspec_focus_sugar_bad_spec.rb')]).to_s.must_equal("\
:syntactic sugar fdescribe|fcontext|fit for focus found in specs:
test/files/rspec_focus_sugar_bad_spec.rb:2:  fcontext 'f prefixed to context' do
test/files/rspec_focus_sugar_bad_spec.rb:3:    fdescribe 'f prefixed to describe' do
test/files/rspec_focus_sugar_bad_spec.rb:4:      fit 'f prefixed to it' do")
  end

end
