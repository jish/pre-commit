require 'minitest/spec'
require 'minitest/rg'
require 'minitest/around'
require 'minitest/autorun'
require 'tmpdir'
require 'pluginator'

class MiniTest::Unit::TestCase

  protected

  def test_filename(filename)
    file_dir = File.expand_path('../files', __FILE__).sub("#{project_dir}/", "")
    File.join(file_dir, filename)
  end

  def write(file, content)
    File.open(file, "w") { |f| f.write content }
  end

  def self.in_temp_dir
    around do |test|
      Dir.mktmpdir do |dir|
        Dir.chdir(dir) do
          yield if block_given?
          test.call
        end
      end
    end
  end

  def ruby_includes
    "-I #{Gem::Specification.find_by_name('pluginator').full_gem_path}/lib -I #{project_dir}/lib"
  end

  def project_dir
    File.expand_path("../../", __FILE__)
  end
end
