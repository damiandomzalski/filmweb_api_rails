Gem::Specification.new do |s|
  s.name        = 'filmweb_api'
  s.version     = '0.1.0'
  s.date        = '2020-04-27'
  s.summary     = "Unofficial Filmweb api"
  s.description = "Simple way to get data from filmweb"
  s.authors     = ["Damian Domzalski"]
  s.email       = 'contact@damiandomzalski.com'
  s.files       = Dir["{lib}/**/*"]
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_development_dependency 'rest-client'
  s.homepage    =
    'https://rubygems.org/gems/filmweb_api'
  s.license       = 'MIT'
end
