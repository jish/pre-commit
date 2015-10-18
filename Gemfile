source "https://rubygems.org"

gemspec

group :development do
  gem "guard", "~> 2.0"
  gem "guard-minitest", "~> 2.0"
  gem "minitest", "~> 4.0"
  gem "minitest-reporters", "~> 0"
  gem "rake", "~> 10.0"
  gem "rubocop", "~> 0.25"

  # checks that do not have to be enabled
  gem "execjs"
  gem "scss-lint"

  # statistics only on MRI 2.0 - avoid problems on older rubies
  gem "redcarpet", :platforms => [:mri_20]
  gem "simplecov", :platforms => [:mri_20]
  gem "coveralls", :platforms => [:mri_20]
end
