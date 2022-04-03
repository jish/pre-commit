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
    check.call([]).must_be_nil
  end

  it "succeeds if there is a migration and a schema change" do
    in_new_directory do
      write "db/migrate/20140718171920_foo.rb", "Yep"
      write "db/schema.rb", "version 20140718171920 bla"
      check.call(['db/migrate/20140718171920_foo.rb', 'db/schema.rb']).must_be_nil
    end
  end

  it "succeeds if there is a migration and a sql schema change" do
    in_new_directory do
      write "db/migrate/20140718171920_foo.rb", "Yep"
      write "db/foo_structure.sql", "version 20140718171920 bla"
      check.call(['db/migrate/20140718171920_foo.rb', 'db/foo_structure.sql']).must_be_nil
    end
  end

  it 'detects multiple versions in a structure file' do
    in_new_directory do
      write "db/migrate/20140718171920_foo.rb", "Yep"
      write "db/foo_structure.sql", <<-STRUCTURE
        INSERT INTO schema_migrations (version) VALUES ('20111115214127');

        INSERT INTO schema_migrations (version) VALUES ('20140718171920');
      STRUCTURE
      check.call(['db/migrate/20140718171920_foo.rb', 'db/foo_structure.sql']).must_be_nil
    end
  end

  it "succeeds if unrelated files are changed" do
    check.call(['public/javascript/foo.js', 'lib/bar.rb']).must_be_nil
  end

  it "succeeds when initial schema is added with version 0" do
    in_new_directory do
      write "db/schema.rb", "brand new 0 version"
      check.call(['db/schema.rb']).must_be_nil
    end
  end

  it "succeeds when schema files use human-friendly date formats" do
    in_new_directory do
      write "db/migrate/20181012040244_add_books.rb", <<-RUBY
        class AddBooks < ActiveRecord::Migration[5.2]
          def change
          end
        end
      RUBY
      write "db/schema.rb", <<-RUBY
        ActiveRecord::Schema.define(version: 2018_10_12_040244) do
        end
      RUBY

      check.call([
        "db/migrate/20181012040244_add_books.rb",
        "db/schema.rb"
      ]).must_be_nil
    end
  end

  it "fails if schema change is missing" do
    check.call(['db/migrate/20140718171920_foo.rb']).must_equal "It looks like you're adding a migration, but did not update the schema file"
  end

  it "fails if migration is missing" do
    in_new_directory do
      write "db/schema.rb", "Nope 20130111131344"
      check.call(['db/schema.rb']).must_equal "You're trying to change the schema without adding a migration file"
    end
  end

  it "fails if the schema change does not include the added versions" do
    in_new_directory do
      write "db/migrate/20140506010100_foo.rb", "class CreateFoos < ActiveRecord::Migration"
      write "db/migrate/20140506010200_bar.rb", "class CreateBars < ActiveRecord::Migration"

      write "db/schema.rb", <<-RUBY
        ActiveRecord::Schema.define(version: 2011_01_01_010100) do
        end
      RUBY

      result = check.call([
        "db/schema.rb",
        "db/migrate/20140506010100_foo.rb",
        "db/migrate/20140506010200_bar.rb"
      ])

      assert_equal(
        "You did not add the schema versions for 20140506010100, 20140506010200 to db/schema.rb",
        result
      )
    end
  end

  it "only lists the missing migration versions" do
    in_new_directory do
      write "db/migrate/20140506010100_foo.rb", "class CreateFoos < ActiveRecord::Migration"
      write "db/migrate/20140506010200_bar.rb", "class CreateBars < ActiveRecord::Migration"
      write "db/migrate/20140506010300_baz.rb", "class CreateBazs < ActiveRecord::Migration"

      write "db/schema.rb", <<-RUBY
        ActiveRecord::Schema.define(version: 2014_05_06_010200) do
        end
      RUBY

      result = check.call([
        "db/schema.rb",
        "db/migrate/20140506010100_foo.rb",
        "db/migrate/20140506010200_bar.rb",
        "db/migrate/20140506010300_baz.rb"
      ])

      assert_equal(
        "You did not add the schema versions for 20140506010100, 20140506010300 to db/schema.rb",
        result
      )
    end
  end
end
