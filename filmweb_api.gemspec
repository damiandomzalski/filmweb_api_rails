Gem::Specification.new do |s|
  s.name        = 'filmweb_api'
  s.version     = '0.1.0.1'
  s.date        = '2020-06-05'
  s.summary     = "Unofficial Filmweb api client"
  s.description = "Simple way to get data from filmweb"
  s.authors     = ["Damian Domzalski"]
  s.email       = 'contact@damiandomzalski.com'
  s.files       = Dir["{lib}/**/*"]
  s.homepage    = "https://github.com/damiandomzalski/filmweb_api_rails"
  s.add_development_dependency 'rspec', '~> 3.9'
  s.add_dependency 'rest-client', '~> 2.0.1'
  s.add_dependency 'activesupport', '~> 5.2'
  s.license       = 'MIT'
end
