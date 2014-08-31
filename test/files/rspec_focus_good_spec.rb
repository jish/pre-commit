describe FocusModel do
  it 'should not trigger the pre-commit focus detector with old hash syntax' do
    expect(FocusModel.new(:focus => true)).to be_valid
  end

  it 'should not trigger the pre-commit focus detector with new hash syntax' do
    expect(FocusModel.new(focus: true)).to be_valid
  end

  it 'should not trigger the pre-commit focus detector with a has key' do
    focus = FocusModel.new
    expect(focus.value_for[:focus]).to eq 'undetected'
  end
end
