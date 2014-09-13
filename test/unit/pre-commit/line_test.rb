require 'minitest_helper'
require 'pre-commit/line'

describe PreCommit::Line do
  describe :to_s do

    subject do
      PreCommit::Line.new("message1")
    end

    it :has_message do
      subject.to_s.must_equal("message1")
    end

    it :has_file do
      subject.file = "path/to/file"
      subject.to_s.must_equal("message1\npath/to/file")
    end

    it :has_file_without_message do
      subject.message = nil
      subject.file = "path/to/file"
      subject.to_s.must_equal("path/to/file")
    end

    it :has_file_and_line do
      subject.file = "path/to/file"
      subject.line = "4"
      subject.to_s.must_equal("message1\npath/to/file:4")
    end

    it :has_no_line_or_code_without_file do
      subject.line = "4"
      subject.code = "  some code"
      subject.to_s.must_equal("message1")
    end

    it :has_file_and_line_and_code do
      subject.file = "path/to/file"
      subject.line = "4"
      subject.code = "  some code"
      subject.to_s.must_equal("message1\npath/to/file:4:  some code")
    end

    it :has_file_and_code do
      subject.file = "path/to/file"
      subject.code = "  some code"
      subject.to_s.must_equal("message1\npath/to/file:  some code")
    end

  end
end
