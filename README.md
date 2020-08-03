# CucumberGithubFormatter

Formatter for cucumber-ruby that creates annotations when running on GitHub Actions

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'cucumber_github_formatter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install cucumber_github_formatter

## Usage

`bundle exec cucumber --format CucumberGithubFormatter --out /dev/null --format pretty`

## Development

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/duderman/cucumber_github_formatter
