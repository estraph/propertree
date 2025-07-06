# Propertree
This gem contains the solution to a fun little [challenge](./CHALLENGE.md): to determine and compare the average property values on streets where the trees are tall with those where trees are short.

## Installation
This library uses SQLite - make sure to install it on your target host. If it's missing, you might see an error like below:

```
sqlite3.h is missing. Try 'brew install sqlite3',
'yum install sqlite-devel' or 'apt-get install libsqlite3-dev'
```

Follow those instructions to install SQLite to proceed.

### RubyGems
Add the GH repo as a gem source and run `gem install`:

```sh
gem sources add 'https://rubygems.pkg.github.com/estraph'
gem install propertree
```

### bundler
Add the GH repo as a source to your `Gemfile` and run `bundle install`:

```ruby
# Gemfile

gem "propertree", source "https://rubygems.pkg.github.com/estraph"
```

## Usage
TODO: Write usage instructions here

## Development
After checking out the repo, run `bin/setup` to install dependencies. Run `bin/check` to run the tests, lint and type checks. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Releases
Push a commit which updates the [version](./lib/propertree/version.rb) and [changelog](./CHANGELOG.md). Then [create a new release in the GH repo](https://github.com/estraph/propertree/releases/new) which will build and push a new gem.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/estraph/propertree.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
