# KashflowApi

[![Build Status](https://travis-ci.org/Ed-ITSolutions/KashflowAPI.png?branch=master)](https://travis-ci.org/Ed-ITSolutions/KashflowAPI) [![Code Climate](https://codeclimate.com/github/Ed-ITSolutions/KashflowAPI.png)](https://codeclimate.com/github/Ed-ITSolutions/KashflowAPI) [![Coverage Status](https://coveralls.io/repos/Ed-ITSolutions/KashflowAPI/badge.png)](https://coveralls.io/r/Ed-ITSolutions/KashflowAPI)

KashflowApi provides an Active Record like interface to the Kashflow API.

# Install

You can install KashflowApi by adding it yo your `Gemfile` like this:

```ruby
gem 'kashflow_api'
```

and running `bundle install`

# Usage

At the beginning of your program, or in an rails initializer call the configure block like so:

``` ruby
KashflowApi.configure do |c|
  c.username = "Username"
  c.password = "Password"
  c.loggers = false
end
```
	
I recommend settings loggers to false so that you don't get all the soap exchanges echoed out.

You can now call methods on the models e.g.

``` ruby
KashflowApi::Customer.all
KashflowApi::Customer.find("Cust01")
KashflowApi::Customer.find_by_email("customer@domain.tld")
```

## Saving

All the Kashflow objects in the gem have a `.save` method which will either insert a new record or update the current one.

# More Info

For more info head over to the [wiki](https://github.com/Ed-ITSolutions/KashflowAPI/wiki)