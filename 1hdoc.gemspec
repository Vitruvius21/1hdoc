require_relative 'lib/1hdoc/version'

Gem::Specification.new do |gem|
  gem.name = '1hdoc'
  gem.version = HDOC::VERSION
  gem.date = Time.now.strftime('%Y-%m-%d')

  gem.summary = '#100DaysOfCode CLI tracker'
  gem.description = 'Keep track of your progress during #100DaysOfCode event.'
  gem.authors = ['Dom Corvasce']
  gem.email = 'dom.corvasce@yandex.com'

  gem.homepage = 'https://github.com/domcorvasce/1hdoc'
  gem.license = 'GPL-3.0'

  # Dependencies (production)
  gem.require_paths = ['lib']
  gem.required_ruby_version = '> 1.9'
  gem.requirements = ['git >= 1.6']

  # Dependencies (development)
  gem.add_development_dependency 'rake', '~> 0'
  gem.add_development_dependency 'rdoc', '~> 0'
  gem.add_development_dependency 'rspec', '~> 3'

  # Dependencies (production)
  gem.add_dependency 'git', '~> 1.3'

  gem.extra_rdoc_files = ['README.md']
  gem.rdoc_options = ['--charset=UTF-8']

  gem.executables << '1hdoc'
  gem.files = [
    'lib/1hdoc.rb',
    'lib/1hdoc/core/configuration.rb',
    'lib/1hdoc/core/log.rb',
    'lib/1hdoc/core/progress.rb',
    'lib/1hdoc/core/repository.rb',
    'lib/1hdoc/version.rb',
    'lib/1hdoc/actions/commit.rb',
    'lib/1hdoc/actions/init.rb',
    'lib/1hdoc/actions/push.rb',
    'lib/1hdoc/actions/version.rb',
    'lib/1hdoc/actions.rb',
    'lib/1hdoc/cli.rb'
  ]
end
