require 'minitest_helper'
require 'tempfile'
require 'stringio'
require 'pre-commit/checks/plugin/config_file'

describe PreCommit::Checks::Plugin::ConfigFile do
  let(:temp_config_file){ Tempfile.new('config.file') }
  let(:config){ MiniTest::Mock.new }
  let(:alternate_location){temp_config_file.path}
  subject do
    PreCommit::Checks::Plugin::ConfigFile.new('my_plugin', config, alternate_location)
  end

  describe 'when configuration is specified by a provider' do
    describe 'when the file exists' do
      it 'returns the provider specified configuration when it exists' do
        config.expect(:get, temp_config_file.path, ['my_plugin.config'])

        subject.location.must_equal(temp_config_file.path)
        config.verify
      end
    end

    describe 'when file does not exist' do
      it 'displays a usage message when the file does not exist' do
        config.expect(:get, 'missing.config', ['my_plugin.config'])

        stderr, $stderr = $stderr, StringIO.new
        subject.location
        stderr, $stderr = $stderr, stderr

        stderr.string.must_equal <<-USAGE
Warning: my_plugin config file 'missing.config' does not exist
Set the path to the config file using:
\tgit config pre-commit.my_plugin.config 'path/relative/to/git/dir/my_plugin.config'
Or in 'config/pre_commit.yml':
\tmy.plugin.config: path/relative/to/git/dir/my_plugin.config
Or set the environment variable:
\texport MY_PLUGIN_CONFIG='path/relative/to/git/dir/my_plugin.config'
my_plugin will look for a configuration file in the project root or use its default behavior.

USAGE
        config.verify
      end
    end
  end

  describe 'when configuration is not specified by a provider and alternate location is specified' do
    before{ config.expect(:get, nil, ['my_plugin.config']) }

    describe 'when the file exists' do
      it 'returns the alternate location' do
        subject.location.must_equal(temp_config_file.path)
      end
    end

    describe 'when the file does not exist' do
      let(:alternate_location){ 'missing.config' }

      it 'returns nil' do
        subject.location.must_equal(nil)
      end
    end
  end

  describe 'when no configuration is specified' do
    before{ config.expect(:get, nil, ['my_plugin.config']) }
    let(:alternate_location){ nil }

    it 'returns nil' do
      subject.location.must_equal(nil)
    end
  end
end
