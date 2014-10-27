lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name         = 'cucumber-formatters'
  spec.summary      = 'A helpful bunch of formatters'
  spec.description  = 'A collection of cucumber formatters'
  spec.homepage     = 'http://benslaughter.github.io/cucumber-formatters/'
  spec.version      = '0.0.2'
  spec.version      = "#{spec.version}-#{ENV['TRAVIS_BUILD_NUMBER']}" if ENV['TRAVIS']
  spec.date         = '2014-10-27'
  spec.license      = 'MIT'

  spec.author       = 'Ben Slaughter'
  spec.email        = 'b.p.slaughter@gmail.com'

  spec.files        = ['README.md', 'LICENSE']
  spec.files        += Dir.glob('lib/**/*.rb')
  spec.files        += Dir.glob('spec/**/*')
  spec.test_files   = Dir.glob('spec/**/*')
  spec.require_path = 'lib'

  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rake'

  spec.add_runtime_dependency 'cucumber'
end
