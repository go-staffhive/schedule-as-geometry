# frozen_string_literal: true

require_relative 'lib/schedule_as_geometry/version'

Gem::Specification.new do |spec|
  spec.name = 'schedule_as_geometry'
  spec.version = ScheduleAsGeometry::VERSION
  spec.authors = ['Alpha']
  spec.email = ['alphanolucifer@gmail.com']

  spec.summary = 'Ruby on Rails gem to support schedule using MySQL Geometry'
  spec.description = 'Ruby on Rails gem to support schedule using MySQL Geometry'
  spec.homepage = 'https://github.com/go-staffhive/schedule-as-geometry'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.1.0'

  spec.metadata['homepage_uri'] = spec.homepage

  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (File.expand_path(f) == __FILE__) ||
        f.start_with?(
          *%w[
            bin/
            test/
            spec/
            features/
            .git
            .circleci
            appveyor
            examples/
            Gemfile
            .rubocop.yml
            .vscode/settings.json
            LICENSE.txt
            lefthook.yml
          ]
        )
    end
  end

  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'rgeo', '>= 3.0.1'
end
