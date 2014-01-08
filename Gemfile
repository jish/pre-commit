source "https://rubygems.org"

gemspec

group :development do
  # checks that do not have to be enabled
  gem "execjs"
  gem "rubocop",          :platforms => [:ruby_19, :ruby_20]

  # statistics only on MRI 2.0 - avoid problems on older rubies
  gem "redcarpet", :platforms => [:mri_20]
  gem "simplecov", :platforms => [:mri_20]
  gem "coveralls", :platforms => [:mri_20]
end
