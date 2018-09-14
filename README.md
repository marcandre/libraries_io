[![Build Status](https://travis-ci.org/marcandre/libraries_io.svg?branch=master)](https://travis-ci.org/marcandre/libraries_io) [![Gem Version](https://badge.fury.io/rb/libraries_io.png)](https://rubygems.org/gems/libraries_io)


# LibrariesIO

This is a wrapper for [Libraries.io](https://libraries.io/api#project-dependencies)'s API.

It implements it in about 100 lines, thanks to the [`tlaw` gem](https://github.com/molybdenum-99/tlaw).

## Installation

1) Add this line to your application's Gemfile:

```ruby
gem 'libraries_io'
```

And then execute:

    $ bundle

2) Get an API key [from Libraries.io](https://libraries.io/account) and specify it either:

## Usage

Example:

```
api = LibrariesIO.new(api_key: 'your_key')

api.search('some_name') # => results

api.platform('rubygems').project('rails').contributors # => list of contributors

# Shortcut to platforms provided:
api.rubygems.project('rails') # ... same
```

Thanks to the `tlaw` gem, the mapping should be pretty obvious and you can check the API source for details, or use `inspect` or `describe`:

```
api.platform('rubygems').project('rails')
# => #<project(id: "rails") endpoints: info, dependencies, dependents, dependent_repositories, contributors, sourcerank, usage; docs: .describe

api.platform('rubygems').project('rails').describe
# => .project(id: "rails")
#  @param id
#
#  Endpoints:
#
#  .info()
#    Get information about a package and it's versions
#
#  .dependencies(version="latest")
#    Get a list of dependencies for a version of a project
#
#  .dependents()
#    Get packages that have at least one version that depends on a given project
#
#  .dependent_repositories()
#    Get repositories that depend on a given project
#
#  .contributors()
#    Get users that have contributed to a given project
#
#  .sourcerank()
#    Get breakdown of SourceRank score for a given project
#
#  .usage()
#    Get breakdown of version usage for a given project

api.platform('rubygems').project('rails').endpoints[:dependents].describe
# => .dependents()
#  Get packages that have at least one version that depends on a given project
#
#  Docs: https://libraries.io/api#project-dependents
```

### API implemented

All documented calls are implemented (except "subscriptions"):

* [api.platforms](https://libraries.io/api#platforms)
* [api.search(q, sort: nil, languages: nil, licenses: nil, keywords: nil, platforms: nil)](https://libraries.io/api#project-search)
* [api.platform(platform_id=nil).project(id=nil).info](https://libraries.io/api#project)
* [api.platform(platform_id=nil).project(id=nil).dependencies(version="latest")](https://libraries.io/api#project-dependencies)
* [api.platform(platform_id=nil).project(id=nil).dependents](https://libraries.io/api#project-dependents)
* [api.platform(platform_id=nil).project(id=nil).dependent_repositories](https://libraries.io/api#project-dependent-repositories)
* [api.platform(platform_id=nil).project(id=nil).contributors](https://libraries.io/api#project-contributors)
* [api.platform(platform_id=nil).project(id=nil).sourcerank](https://libraries.io/api#project-sourcerank)
* [api.platform(platform_id=nil).project(id=nil).usage](https://libraries.io/api#project-usage)
* [api.repository(owner:, name:, host: "github").info](https://libraries.io/api#repository)
* [api.repository(owner:, name:, host: "github").dependencies](https://libraries.io/api#repository-dependencies)
* [api.repository(owner:, name:, host: "github").projects](https://libraries.io/api#repository-projects)
* [api.user(name, host: "github").info](https://libraries.io/api#user)
* [api.user(name, host: "github").repositories](https://libraries.io/api#user-repositories)
* [api.user(name, host: "github").projects](https://libraries.io/api#user-projects)
* [api.user(name, host: "github").repository_contributions](https://libraries.io/api#user-repository-contributions)
* [api.user(name, host: "github").dependencies(platform: nil)](https://libraries.io/api#user-dependencies)

### API Key

You can specify the API key in various ways:

* providing it when instantiating an API: `LibrariesIO.new(api_key: 'your_key')`
* as an environment variable `LIBRARIES_IO_API_KEY`
* setting the global `LibrariesIO.api_key = "your_key"` after the library is loaded
* writing it in a local file `.libraries_io_api_key`

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/marcandre/libraries_io. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the LibrariesIO project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/marcandre/libraries_io/blob/master/CODE_OF_CONDUCT.md).
