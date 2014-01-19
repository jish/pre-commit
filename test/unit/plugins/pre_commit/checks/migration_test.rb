require 'minitest_helper'
require 'tmpdir'
require 'plugins/pre_commit/checks/migration'

describe PreCommit::Checks::Migration do
  let(:check) { PreCommit::Checks::Migration.new(nil, nil, []) }

  def in_new_directory(&block)
    Dir.mktmpdir do |dir|
      Dir.chdir(dir, &block)
    end
  end

  def write(file, content)
    FileUtils.mkdir_p(File.dirname(file))
    File.open(file, 'w') { |f| f.write content }
  end

  it "succeeds if there is no change" do
    check.call([]).must_equal nil
  end

  it "succeeds if there is a migration and a schema change" do
    in_new_directory do
      write "db/migrate/01_foo.rb", "Yep"
      write "db/schema.rb", "version 01 bla"
      check.call(['db/migrate/01_foo.rb', 'db/schema.rb']).must_equal nil
    end
  end

  it "succeeds if there is a migration and a sql schema change" do
    in_new_directory do
      write "db/migrate/01_foo.rb", "Yep"
      write "db/foo_structure.sql", "version 01 bla"
      check.call(['db/migrate/01_foo.rb', 'db/foo_structure.sql']).must_equal nil
    end
  end

  it "succeeds if random files are changed" do
    check.call(['public/javascript/foo.js', 'lib/bar.rb']).must_equal nil
  end

  it "fails if schema change is missing" do
    check.call(['db/migrate/01_foo.rb']).must_equal "It looks like you're adding a migration, but did not update the schema file"
  end

  it "fails if migration is missing" do
    check.call(['db/schema.rb']).must_equal "You're trying to change the schema without adding a migration file"
  end

  it "fails if the schema change does not include the added versions" do
    in_new_directory do
      write "db/migrate/123_foo.rb", "Nope"
      write "db/migrate/234_foo.rb", "Nope"
      write "db/schema.rb", "Nope"
      check.call(['db/schema.rb', 'db/migrate/234_foo.rb', 'db/migrate/123_foo.rb']).must_equal "You did not add the schema versions for 234, 123 to db/schema.rb"
    end
  end
end
