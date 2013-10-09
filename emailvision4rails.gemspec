$LOAD_PATH.unshift 'lib'
require 'emailvision4rails/version'

Gem::Specification.new do |s|
  s.name = "emailvision4rails"
  s.summary = "Emailvision library for Ruby on Rails"
  s.description = "Manage Emailvision campaigns and messages from your rails application" 
  s.version = Emailvision4rails::Version
  s.date = Time.now.strftime('%Y-%m-%d')

  s.files = Dir["{app,lib,config}/**/*"] + ["MIT-LICENSE", "Rakefile", "Gemfile", "README.markdown"]
  s.require_path = 'lib'  
	
	s.authors     = ['Bastien Gysler']  
	s.email       = "basgys@gmail.com"
  s.homepage    = "https://github.com/basgys/emailvision4rails"

  s.add_dependency("rails", ">= 3.2")

  s.add_dependency("emailvision", "~> 2.1.0")
  s.add_dependency("premailer", "~> 1.7.0")
  s.add_dependency("hpricot", "~> 0.8.0")
end