# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bondage}
  s.version = "0.1.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Justin Love"]
  s.date = %q{2010-01-17}
  s.description = %q{class Binding stinks, module Bondage stinks less.  Bondage provides hashes of local, global, instance, etc. variables, and provides the Enumerable interface for locals directly.  It also provides [] syntax to get/set binding variables directly.}
  s.email = ["git@JustinLove.name"]
  s.extra_rdoc_files = ["History.txt", "Manifest.txt", "README.rdoc"]
  s.files = ["History.txt", "Manifest.txt", "README.rdoc", "Rakefile", "description.rdoc", "lib/bondage.rb", "script/console", "script/destroy", "script/generate", "spec/bondage_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "synopsis.rb", "tasks/readme.rake", "tasks/rspec.rake"]
  s.homepage = %q{http://github.com/JustinLove/bondage}
  s.rdoc_options = ["--main", "README.rdoc"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{bondage}
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{class Binding stinks, module Bondage stinks less}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<hoe>, [">= 2.3.3"])
    else
      s.add_dependency(%q<hoe>, [">= 2.3.3"])
    end
  else
    s.add_dependency(%q<hoe>, [">= 2.3.3"])
  end
end
