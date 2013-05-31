require 'bitly'
require 'multi_bitly'

Bitly.use_api_version_3

class BitlyAccount
  def self.where(*args)
    []
  end
end

class ApiClient
  def initialize(username, api_key)
  end

  def shorten(url)
    Struct.new('ApiClient') do
      def long_url; 'http://www.google.com'; end
      def short_url; 'http://bit.ly/g123'; end
      def user_hash; 'g123'; end
    end.new
  end
end

def set_configuration
  MultiBitly::configure do |config|
    config.accounts = [
      { username: 'user1', api_key: 'key1' },
      { username: 'user2', api_key: 'key2' }
    ]
  end
end
