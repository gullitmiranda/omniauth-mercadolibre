$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "omniauth/mercado_libre/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |gem|
  gem.add_dependency 'omniauth', '~> 1.0'

  gem.authors     = ["Gullit Miranda"]
  gem.email       = ["gullitmiranda@requestdev.com.br"]
  gem.description = %q{A MercadoLibre OAuth2 strategy for OmniAuth 1.x}
  gem.summary     = %q{A MercadoLibre OAuth2 strategy for OmniAuth 1.x}
  gem.homepage    = "http://www.requestdev.com.br"

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {spec}/*`.split("\n")
  # gem.require_paths = ["lib"]

  gem.name        = "omniauth-mercadolibre"
  gem.version     = OmniAuth::MercadoLibre::VERSION

  gem.add_runtime_dependency 'omniauth-oauth2'

  gem.add_development_dependency "rspec", "~> 2.14.1"
  gem.add_development_dependency 'rake'
end
