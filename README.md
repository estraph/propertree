# Propertree
This gem contains the solution to a fun little [challenge](./CHALLENGE.md): to determine and compare the average property values on streets where the trees are tall with those where trees are short.

### TL;DR
If you just want to run this thing and check the answer, this is how:
- `asdf install`: install ruby 3.4.4
- `gem install bundler`: install bundler
- `bin/setup`: install dependencies
- `bin/check`: run tests
- `bundle exec exe/calculate_averages dublin-trees.json dublin-property.csv`: calculate the averages. output:

```sh
2025-07-08 01:14:00 +0100  INFO: average cost of a property
- on a street with tall trees: 587800.39
- on a street with short trees: 488981.66
```

### Notes
Some assumptions and decisions I made which are worth mentioning, and discussing in a follow-up chat:
- avoided traversing JSON, instead "grep" for relevant lines
- assumptions about file structure
- assuming re-use, gem is ideal. CLI to run, and Models to access in custom code
- SQLite because relational problem calls for a (lightweight) relational DB
- ActiveRecord and ActiveModel are production-ready ORM and model framework (used in Rails)
- CI and semi-automatic release
- TODO: error messages
- TODO: variable naming
- optimise for feedback loops
- probably a little bit overkill for the logic enclosed; worth it on a team
- skipped type checking, got in the way, and am not convinced it's worth it

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
Install the gem as instructed above. You have two ways of interacting with the code: either through the executable provided, or by accessing the internal models directly.

### application executable
The gem contains a binary called `calculate_averages` which accepts three parameters:
- the first mandatory parameter is the path to a JSON file containing the street names and median tree heights ([example](./dublin-trees.json))
- the second manatory parameter is the path to a CSV file containing the properties with their respective prices ([example](./dublin-property.csv))
- optionally, the flag `-v` can be passed to enable verbose output for troubleshooting purposes

### model access
The models `Propertree::Models::Property` and `Propertree::Models::Street` can be used to load data into the in-memory DB and subsequently query it for insights, such as is currently done for the average prices.

## Development
After checking out the repo, run `bin/setup` to install dependencies. Run `bin/check` to run the tests, lint and type checks. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

### Releases
Push a commit which updates the [version](./lib/propertree/version.rb) and [changelog](./CHANGELOG.md). Then [create a new release in the GH repo](https://github.com/estraph/propertree/releases/new) which will build and push a new gem.

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/estraph/propertree.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
