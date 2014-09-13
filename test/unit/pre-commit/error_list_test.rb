require 'minitest_helper'
require 'pre-commit/error_list'

describe PreCommit::ErrorList do

  it :starts_empty do
    result = PreCommit::ErrorList.new()
    result.errors.must_equal []
  end

  it :creates_array_from_string do
    result = PreCommit::ErrorList.new("message1")
    result.errors.must_equal [PreCommit::Line.new("message1")]
  end

  it :uses_array_for_errors do
    result = PreCommit::ErrorList.new([1,2])
    result.errors.must_equal [1,2]
  end

  it :converts_errors_to_strings_in_to_a do
    result = PreCommit::ErrorList.new([1,2])
    result.to_a.must_equal ["1","2"]
  end

  it :converts_errors_to_string_in_to_s do
    result = PreCommit::ErrorList.new([1,2])
    result.to_s.must_equal "1\n2"
  end

end
