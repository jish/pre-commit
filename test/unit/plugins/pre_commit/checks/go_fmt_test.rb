require 'minitest_helper'
require 'plugins/pre_commit/checks/go_fmt'

describe PreCommit::Checks::GoFmt do
  let(:check) {PreCommit::Checks::GoFmt.new(nil, nil, [])}

  it "succeds if nothing changed" do
    check.call([]).must_equal nil
  end

  it "succeeds for good code" do
    check.call([fixture_file('good.go')]).must_equal ""
  end

  it "fails for bad formatted code" do
    check.call([fixture_file("bad_fmt.go")]).must_match(/bad_fmt.go/)
  end

end unless `which go 2>/dev/null`.empty?
