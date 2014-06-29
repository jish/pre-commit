require 'minitest_helper'
require 'plugins/pre_commit/checks/go'

describe PreCommit::Checks::Go do
  let(:check) {PreCommit::Checks::Go.new(nil, nil, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.go')]).must_equal ""
  end

  it "fails for bad formatted code" do
    check.call([fixture_file("bad_fmt.go")]).must_match(/bad_fmt.go/)
  end

  it "fails for compiler errors" do
    check.call([fixture_file("dont_compile.go")]).must_match(/imported and not used/)
  end
end unless `which go 2>/dev/null`.empty?
