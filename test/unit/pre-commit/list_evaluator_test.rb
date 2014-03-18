require 'minitest_helper'
require 'pre-commit/list_evaluator'
require 'plugins/pre_commit/configuration/providers/default'
require 'plugins/pre_commit/configuration/providers/git'
require 'plugins/pre_commit/checks/before_all'
require 'plugins/pre_commit/checks/console_log'

describe PreCommit::ListEvaluator do
  let :configuration do
    PreCommit::Configuration.new(
      PreCommit.pluginator,
      PreCommit::Configuration::Providers.new(nil, [
        PreCommit::Configuration::Providers::Default.new({}),
      ])
    )
  end

  subject do
    PreCommit::ListEvaluator.new(configuration)
  end

  it :list do
    subject.list.gsub(/\s+\n/,"\n").must_equal(<<-EXPECTED)
Available providers: default(0)
Available checks   : before_all ci closure coffeelint common console_log csslint debugger gemfile_path go jshint jslint json local merge_conflict migration nb_space php pry rails rspec_focus rubocop ruby ruby_symbol_hashrockets tabs whitespace
Default   checks   :
Enabled   checks   :
Evaluated checks   :
Default   warnings :
Enabled   warnings :
Evaluated warnings :
EXPECTED
  end

  it "plugins have includes" do
    list = subject.send(:format_plugin, "ruby", "6", configuration.pluginator.find_check(:ruby)).must_equal([
      "  ruby : Plugins common for ruby.",
      "       - includes: pry local",
    ])
  end
  it "plugins have excludes" do
    list = subject.send(:format_plugin, "rubocop", "7", configuration.pluginator.find_check(:rubocop)).must_equal([
      "rubocop : Runs rubocop to detect errors.",
      "        - excludes: ruby_symbol_hashrocket",
    ])
  end
end
