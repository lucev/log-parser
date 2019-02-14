# Log parser

Ruby script that accepts webserver log as an input and prints number of page views and unique visits for every page.

## Getting started

1. Clone repository on your local machine

```ruby
git clone git@github.com:lucev/log-parser.git
```

2. Change directory
```ruby
cd log-parser
```

3. Execute the log parser with provided example (or pass the path to another log file)
```ruby
./parser.rb webserver.log
```

## Running tests

1. Tests are written in RSpec so you have to install it as dependency

```
bundle install
```

2. Run tests on your local machine
```ruby
bundle exec rspec spec/
```
