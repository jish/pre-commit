describe RspecFocusSugarChecks do
  fcontext 'f prefixed to context' do
    fdescribe 'f prefixed to describe' do
      fit 'f prefixed to it' do
      end
    end
  end
end
