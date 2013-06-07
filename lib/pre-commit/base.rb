require 'pathname'

module PreCommit

  def self.root
    root = File.expand_path('../../..', __FILE__)
    Pathname.new(root)
  end

end
