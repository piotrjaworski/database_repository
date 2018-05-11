# DatabaseRepository

Welcome to the DatabaseRepository gem!
This gem was written to provide an extra layer to your Ruby applications called **repositories**.
Repositories are used to interact with our database - execute all queries.
Thanks to them, you don't need to write anymore **ActiveRecord code** inside your models, controllers, and services - everything is much simpler to maintain!

This gem requires just **ActiveRecord**, not **Rails** - feel free to use it without Rails in your Rack applications!

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'database_repository'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install database_repository

## How to create a repository

To create a new repository, you just need to run a Rails generator (if you use Rails):

    $ rails generate database_repository:repository your_repository_name

For example:

    $ rails generate database_repository:repository user

A new repository will be generated under:
- app/repositories/user_repository.rb

You can also add the new repository to app/repositories, your class should inherit from `DatabaseRepository::Base` class, like:
```ruby
class UserRepository < DatabaseRepository::Base
end
```

## Dependencies

- ActiveRecord >= 3.2

## Usage

If you want to use your repository, you should create a new instance of a repository, then call a method which will return some data:
```ruby
users_repository = UserRepository.new
users = users_repository.all
user = users_repository.find(2)
```

By default, a repository maps to a model by a repository's name, for example:
- UserRepository -> User
- LineItemRepository -> LineItem
- User::LineItemRepository -> User::LineItem

If you want to change a model, you can redefine a class name:
```ruby
class UsersRepository < DatabaseRepository::Base
  entity 'Model'
end
```

#### Preimplemented methods:
- `all`
calls ActiveRecord **Model.all** method.

- `build(attributes)`
calls ActiveRecord **Model.new(attributes)** method.

- `find(id)`
calls ActiveRecord **Model.find(id)** method.
Raises `DatabaseRepository::RecordNotFound` if a record is not found.

- `find_by(id)`
calls ActiveRecord **Model.find_by(id)** method.

- `find_or_initialize_by(id)`
calls ActiveRecord **Model.find_or_initialize_by(id)** method.

- `find_or_create_by(attributes)`
calls ActiveRecord **Model.find_or_create_by(attributes)** method.

- `find_or_create_by!(attributes)`
calls ActiveRecord **Model.find_or_create_by!(attributes)** method. Raises `DatabaseRepository::RecordInvalid` if a record is invalid.

- `first(id)`
calls ActiveRecord **Model.first(id)** method.

- `first!(id)`
calls ActiveRecord **Model.first!(id)** method.
Raises `DatabaseRepository::RecordNotFound` if a record is not found.

- `last(id)`
calls ActiveRecord **Model.last(id)** method.

- `last!(id)`
calls ActiveRecord **Model.last!(id)** method.
Raises `DatabaseRepository::RecordNotFound` if a record is not found.

- `create(attributes)`
calls ActiveRecord **Model.create(attributes)** method.

- `create!(attributes)`
calls ActiveRecord **Model.create!(attributes)** method.
Raises `DatabaseRepository::RecordInvalid` if a record is invalid.

- `update(id, attributes)`
calls ActiveRecord **Model.update(id, attributes)** method.

- `update!(id, attributes)`
calls ActiveRecord **Model.update!(id, attributes)** method.
Raises `DatabaseRepository::RecordInvalid` if a record is invalid.

- `update_all(attributes)`
calls ActiveRecord **Model.update_all(attributes)** method.

- `delete(id)`
calls ActiveRecord **Model.delete(id)** method.

- `destroy(id)`
calls ActiveRecord **Model.destoy(id)** method.

- `destroy!(id)`
calls ActiveRecord **Model.destroy!(id)** method.
Raises `DatabaseRepository::RecordNotDestroyed` if a record cannot be destroyed.

- `delete_all`
calls ActiveRecord **Model.delete_all** method.

- `destroy_all`
calls ActiveRecord **Model.destroy_all** method.

### Your own methods

If you want to add your methods, just write a regular ActiveRecord code, for example:
```ruby
class UserRepository < DatabaseRepository::Base
  def most_recent_by_name(name:, limit: 5)
    where(name: name).
    order(created_at: :desc).
    limit(limit)
  end
end
```

Then, inside your service, controller or any other class:
```ruby
UserRepository.new.most_recent_by_name(name: 'Piotr Jaworski', limit: 10)
```

Voila! That's all!

## TODO

- Add Sequel support

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/piotrjaworski/database_repository. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License
MIT License. Copyright 2018 Piotr Jaworski - http://piotrjaworski.pl.
