# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pre-commit}
  s.version = "0.1.11"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shajith Chacko, Josh Lubaway"]
  s.date = %q{2011-05-05}
  s.default_executable = %q{pre-commit}
  s.email = %q{dontneedmoreemail@example.com}
  s.executables = ["pre-commit"]
  s.extra_rdoc_files = ["README.md"]
  s.files = Dir["lib/**/*"]
  s.homepage = %q{http://github.com/jish/pre-commit}
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{What this thing does}

  if s.respond_to? :specification_version then
    s.specification_version = 3
  end
end
