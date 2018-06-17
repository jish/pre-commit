require 'minitest_helper'
require 'plugins/pre_commit/checks/json'

describe PreCommit::Checks::Json do
  let(:check) {PreCommit::Checks::Json.new(nil, nil, [])}

  it "succeds if nothing changed" do
    check.call([]).must_be_nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.json')]).must_be_nil
  end

  it "fails for bad formatted code" do
    errors = check.call([fixture_file("bad.json")])
    errors.must_match(/unexpected token at '}/)
    errors.must_match(%r{parsing test/files/bad.json})
  end
end
