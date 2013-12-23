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

  # rubinius support
  gem "rubysl-json",      :platforms => [:rbx]
  gem "rubysl-mutex_m",   :platforms => [:rbx]
  gem "rubysl-open3",     :platforms => [:rbx]
  gem "rubysl-singleton", :platforms => [:rbx]
  gem "rubysl-stringio",  :platforms => [:rbx]
end
