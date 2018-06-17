# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pre-commit}
  s.version = "0.38.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shajith Chacko, Josh Lubaway"]
  s.default_executable = %q{pre-commit}
  s.email = %q{dontneedmoreemail@example.com}
  s.executables = ["pre-commit"]
  s.extra_rdoc_files = ["README.md"]
  s.files = Dir["bin/*", "lib/**/*", "templates/**/*"]
  s.homepage = %q{http://github.com/jish/pre-commit}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.license = 'Apache-2.0'
  s.summary = "A slightly better git pre-commit hook"
  s.description = "A git pre-commit hook written in ruby with a few more tricks up its sleeve"

  s.add_dependency('pluginator', '~> 1.5')
  s.add_dependency('execjs')

  s.add_development_dependency('benchmark-ips')
  s.add_development_dependency('minitest', '~> 5.0')
  s.add_development_dependency('minitest-reporters', '~> 1.0')
  s.add_development_dependency('rake', '~> 10.0')
  s.add_development_dependency('rubocop', '~> 0.49')

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end
end
