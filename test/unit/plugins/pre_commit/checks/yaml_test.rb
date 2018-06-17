require 'minitest_helper'
require 'plugins/pre_commit/checks/yaml'

describe PreCommit::Checks::Yaml do
  let(:check) {PreCommit::Checks::Yaml.new(nil, nil, [])}

  it "succeds if nothing changed" do
    check.call([]).must_be_nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.yml')]).must_be_nil
  end

  it "skips files with serialized ruby" do
    $stdout, stdout = StringIO.new, $stdout
    check.call([fixture_file('serialized.yml')])
    $stdout, stdout = stdout, $stdout

    stdout.string.must_equal("Warning: Skipping 'test/files/serialized.yml' because it contains serialized ruby objects.\n")
  end

  it "fails for bad formatted code" do
    # JRuby Error: (test/files/bad.yml): found character % '%' that cannot start any token. (Do not use % for indentation) while scanning for the next token at line 2 column 11
    # Other Rubies: (test/files/bad.yml): found character that cannot start any token while scanning for the next token at line 2 column 11

    check.call([fixture_file("bad.yml")]).must_match(%r{test/files/bad.yml.* found character.* that cannot start any token.* line 2 column 11})
  end
end
