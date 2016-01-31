require 'minitest_helper'
require 'plugins/pre_commit/checks/go_build'

describe PreCommit::Checks::GoBuild do
  let(:check) {PreCommit::Checks::GoBuild.new(nil, nil, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.go')]).must_equal ""
  end

  it "fails for compiler errors" do
    check.call([fixture_file("dont_compile.go")]).must_match(/imported and not used/)
  end
end unless `which go 2>/dev/null`.empty?
