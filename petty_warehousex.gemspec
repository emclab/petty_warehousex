$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "petty_warehousex/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "petty_warehousex"
  s.version     = PettyWarehousex::VERSION
  s.authors     = ["Your name"]
  s.email       = ["Your@email.com"]
  s.homepage    = "http://home.com"
  s.summary     = "Summary of PettyWarehousex."
  s.description = "Description of PettyWarehousex."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~>4.2.0"
  s.add_dependency "jquery-rails"
  s.add_dependency "simple_form"
  s.add_dependency "will_paginate"
  s.add_dependency "database_cleaner"
  s.add_dependency "execjs"
  s.add_dependency "sass-rails", '~>5.0.1'
  s.add_dependency "coffee-rails", '~>4.1.0'   
  s.add_dependency "uglifier", '~>2.7.0'

  s.add_development_dependency "sqlite3"
  s.add_development_dependency "rspec-rails", ">= 3.2.0"
  s.add_development_dependency "factory_girl_rails", '~>4.5'
  s.add_development_dependency 'capybara'
  s.add_development_dependency 'launchy'   #with capybara
end
