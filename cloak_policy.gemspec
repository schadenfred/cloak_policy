$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "cloak_policy/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "cloak_policy"
  spec.version     = CloakPolicy::VERSION
  spec.authors     = ["fred schoeneman"]
  spec.email       = ["fred.schoeneman@gmail.com"]
  spec.homepage    = ""
  spec.summary     = ""
  spec.description = ""
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails"
  spec.add_dependency "haml-rails"
  spec.add_dependency "sass-rails"

  spec.add_dependency "bootstrap"
  spec.add_dependency "ranked-model"
  spec.add_dependency "jquery-rails"
  spec.add_dependency "jquery-ui-rails"
  spec.add_dependency "fast_jsonapi"
  spec.add_dependency "turbolinks"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "better_errors"
  spec.add_development_dependency "binding_of_caller"
  spec.add_development_dependency "apparition"
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "shoulda-context", "2.0.0.rc2"
  spec.add_development_dependency "shoulda-matchers", '~> 4.0'
  spec.add_development_dependency "minitest-matchers_vaccine"

  spec.add_development_dependency "handsome_fencer-test"
end
