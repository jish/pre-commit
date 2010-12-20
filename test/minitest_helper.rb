require 'minitest/autorun'

class MiniTest::Unit::TestCase

  protected

  def test_filename(filename)
    file_dir = File.expand_path('../files', __FILE__)
    File.join(file_dir, filename)
  end

end
