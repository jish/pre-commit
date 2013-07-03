require 'minitest/spec'
require 'minitest/rg'
require 'minitest/autorun'
$LOAD_PATH << File.expand_path("../../lib", __FILE__)

class MiniTest::Unit::TestCase

  protected

  def test_filename(filename)
    file_dir = File.expand_path('../files', __FILE__).sub("#{Bundler.root}/", "")
    File.join(file_dir, filename)
  end

end
