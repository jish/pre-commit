require 'minitest/autorun'
require 'minitest/rg'
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

  def create_temp_dir
    @dir = Dir.mktmpdir(nil, ENV['TMPDIR'] || '/tmp')
    @old_dir = Dir.pwd
    Dir.chdir(@dir)
  end

  def destroy_temp_dir
    Dir.chdir(@old_dir)
    FileUtils.rm_rf(@dir)
  end

  def ruby_includes
    "-I #{Gem::Specification.find_by_name('pluginator').full_gem_path}/lib -I #{project_dir}/lib"
  end

  def start_git
    sh "git init"
  end

  def project_dir
    File.expand_path("../../", __FILE__)
  end

  def sh(command, options={})
    result = `#{command} 2>&1`
    raise "FAILED #{command}\n#{result}" if $?.success? == !!options[:fail]
    result
  end

end
