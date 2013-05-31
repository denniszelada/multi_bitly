# MultiBitly

Allows access to the bit.ly API with multiple accounts.

MultiBitly is a wrapper around the [Bitly](https://github.com/philnash/bitly) gem that makes it easy to generate multiple shortened Bitly links for a given URL.

When shortening a URL, Bitly will return the same hash regardless of how many times you request a new one. One way around this is to use a different Bitly account to shorten the same URL, resulting in a different hash.

Such a pain. Until now.

Now, with a list of Bitly accounts, MultiBitly will automatically shorten URLs for each account, resulting in a list of shortened Bitly links for one URL.

### So what?

If you've ever wanted to use Bitly links as distribution channels to track a URL, you're going to be a [whole](http://cutestuff.co/wp-content/uploads/2011/09/tumblr_lr6ed9uQSi1qzfvwyo1_500.jpg) [lot](http://www.stevecurtin.com/blog/wp-content/uploads/2011/10/Cute-puppy.jpg) [happier](http://onwardstate.com/wp-content/uploads/2013/04/puppy1.jpg). Just keep track of which account has already shortened the URL, and we'll take care of the rest.

## Installation

Add this to your Gemfile

    gem install multi_bitly

MultiBitly currently requires an ActiveRecord class that keeps track of the usernames and URLs already shortened through Bitly. The default name is `BitlyAccount`, but you can override it in the config.

You will also need to create an initializer to set the account information. You can find a Bitly account's API key [here](https://bitly.com/a/your_api_key).

## Show me the code

    # config/initializers/multi_bitly.rb
    MultiBitly::configure do |config|
      config.accounts = [
        { username: 'user1', api_key: 'key1' },
        { username: 'user1', api_key: 'key2' }
      ]
    end

    # app/models/bitly_account.rb
    class BitlyAccount < ActiveRecord::Base
      attr_accessible :username, :url

      validates :username, :url, presence: true
      validates :username, uniqueness: { scope: :url } # one URL per user
    end

    # a sample class to shorten a URL and mark the account that shortened it
    class ShortenAllTheThings

    def initialize(url)
      @url = url
    end

    def shorten
      client = MultiBitly::Client.new
      response = client.shorten(@url)
      BitlyAccount.create!(username: response.account.username, url: 'http://google.com')
      response.short_url
    end

    ShortenAllTheThings.new('http://google.com').shorten # => http://bit.ly/900913
    ShortenAllTheThings.new('http://google.com').shorten # => http://bit.ly/11JpHp5
    # now we're all out of acounts so we'll use the last one
    ShortenAllTheThings.new('http://google.com').shorten # => http://bit.ly/11JpHp5

## Contributors
* [Danny Olson](https://github.com/dbolson)

## Contributions welcome
Any contributions are welcome. Simply follow the steps below to get started:

1. Fork it
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Added some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create new Pull Request
