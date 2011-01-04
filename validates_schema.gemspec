# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{validates_schema}
  s.version = "1.1.2.20110104122932"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["markbates"]
  s.date = %q{2011-01-04}
  s.description = %q{validates_schema was developed by: markbates}
  s.email = %q{mark@markbates.com}
  s.extra_rdoc_files = ["README", "LICENSE"]
  s.files = ["lib/validates_schema/validates_schema.rb", "lib/validates_schema.rb", "README", "LICENSE"]
  s.homepage = %q{http://www.metabates.com}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{validates_schema}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{validates_schema}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activerecord>, [">= 3.0.0"])
    else
      s.add_dependency(%q<activerecord>, [">= 3.0.0"])
    end
  else
    s.add_dependency(%q<activerecord>, [">= 3.0.0"])
  end
end
