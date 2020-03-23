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

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.2"
  spec.add_dependency "haml-rails"
  spec.add_dependency "sass-rails"

  spec.add_development_dependency "pg"
  spec.add_development_dependency "minitest"
  # spec.add_development_dependency "minitest-rails-capybara"
  spec.add_development_dependency "minitest-given"
  spec.add_development_dependency "launchy"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "guard-livereload"
  spec.add_development_dependency "rack-livereload"
  # spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "better_errors"
  spec.add_development_dependency "binding_of_caller"
  spec.add_development_dependency "apparition"
  spec.add_development_dependency "capybara" 
  spec.add_development_dependency "selenium-webdriver"
  spec.add_development_dependency "shoulda-context", "2.0.0.rc2"
  spec.add_development_dependency "shoulda-matchers", '~> 4.0'
  # gem 'shoulda-matchers', '~> 4.0'"
  spec.add_development_dependency "minitest-matchers_vaccine"

   




  # spec.add_development_dependency "handsome_fencer-test"
end
