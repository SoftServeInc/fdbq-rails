$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "fdbq/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "fdbq-rails"
  spec.version     = Fdbq::Rails::VERSION
  spec.authors     = ["SoftServe OpenSource"]
  spec.email       = ["opensource@softserveinc.com"]
  spec.homepage    = "https://github.com/SoftServeInc/fdbq-rails"
  spec.summary     = "Fdbq::Rails. A Rails integration for Fdbq JS plugin."
  spec.description = "Fdbq::Rails. A Rails integration for Fdbq JS plugin."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib,vendor/node_modules}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 3"
  spec.add_dependency "jbuilder"

  spec.add_development_dependency "sqlite3"
end
