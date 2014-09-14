describe RspecFocusChecks do
  context 'with old hash syntax', :focus => true do
    describe 'focus on describe', :focus => true do
      it 'alerts with focus on example too', :focus => true do
      end
    end
  end

  context 'with new hash syntax', focus: true do
    describe 'focus on describe', focus: true do
      it 'alerts with focus on example too', focus: true do
      end
    end
  end

  context 'with symbols as keys', :focus do
    describe 'focus on describe', :focus do
      it 'alerts with focus on example too', :focus do
      end
    end
  end
end
