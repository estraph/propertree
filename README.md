# Propertree
This gem contains the solution to a fun little [challenge](./CHALLENGE.md): to determine and compare the average property values on streets where the trees are tall with those where trees are short.

### TL;DR
If you just want to run this thing and check the answer, this is how:
- `asdf install`: install ruby 3.4.4
- `gem install bundler`: install bundler
- `bin/setup`: install dependencies
- `bin/check`: run tests
- `bundle exec exe/calculate_averages dublin-trees.json dublin-property.csv`: calculate the averages. output:

See the [Installation](#installation) section for more details.

```sh
2025-07-08 01:14:00 +0100  INFO: average cost of a property
- on a street with tall trees: 587800.39
- on a street with short trees: 488981.66
```

The data shows: **YES**, houses *are* more expensive on streets with tall trees compared to those with shorter trees.

### Notes
The following are some thoughts and notes on decisions made, and which we can dig into in a follow-up conversation.

#### Ruby gem
I have packaged this solution as a Ruby gem for two reasons: the challenge suggested a production scenario, and it was implied that engineers might want to re-use the logic in other applications. Rather than assume they would copy and paste it (which I wouldn't appreciate in production), the canonical way for sharing code in Ruby is through a gem. Thus, this gem is also hosted on GitHub and includes CI for rapid feedback and basic release automation. I would approach this in a similar manner in a real team (and have before).

#### Relational DB
The operations required for determining the average price could have easily been complted using just Ruby functionality, by processing the data in lists and maps. I chose to use SQLite instead, because the scenario aked for what I'd do in a production situation. SQLite, combined with ActiveRecord and ActiveModel, gives me a lot for free: input validation, consistency checks and efficient operations for querying the data, including the average price. The resulting code is also arguably more intuitive to the average Ruby developer because it uses libraries and patterns familiar from the Rails framework.

#### Sanitising the data
The input data required some cleanup, e.g. the currency values in the CSV and because the JSON data had an irregular structure.
I chose to do the simplest thing to work with the data presented and not generalise it further:
- I assumed that property prices will not be presented in arbitrary formats besides what is in the file.
- I assumed that the fields containing the height per street in the JSON is always on a separate line

This means the logic is vulnerable to subtle and very possible changes in the input data. For this exercise, I chose to assume data will always arrive in this exact format and thus keep the complexity lower. We can make things more complex later, if ever required.

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
