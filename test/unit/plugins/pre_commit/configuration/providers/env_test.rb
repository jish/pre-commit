require 'minitest_helper'
require 'plugins/pre_commit/configuration/providers/env'

describe PreCommit::Configuration::Providers::Env do
  subject do
    PreCommit::Configuration::Providers::Env
  end

  it "has priority" do
    subject.priority.must_equal(30)
  end

  describe :environment do
    subject do
      PreCommit::Configuration::Providers::Env.new
    end

    before do
      ENV['GETTABLE_CONFIGURATION'] = 'test'
      ENV['SETTABLE_CONFIGURATION'] = nil
    end

    after do
      ENV['GETTABLE_CONFIGURATION'] = nil
      ENV['SETTABLE_CONFIGURATION'] = nil
    end

    it 'reads from the environment' do
      subject['gettable.configuration'].must_equal('test')
    end

    it 'writes to the environment' do
      subject.update('settable.configuration', 'test')
      ENV['SETTABLE_CONFIGURATION'].must_equal('test')
    end
  end
end
