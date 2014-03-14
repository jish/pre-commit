require 'minitest_helper'
require 'plugins/pre_commit/checks/yaml'

describe PreCommit::Checks::Yaml do
  let(:check) {PreCommit::Checks::Yaml.new(nil, nil, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.yml')]).must_equal nil
  end

  it "fails for bad formatted code" do
    check.call([fixture_file("bad.yml")]).must_equal <<-ERROR
(test/files/bad.yml): found character that cannot start any token while scanning for the next token at line 2 column 11
ERROR
  end
end
