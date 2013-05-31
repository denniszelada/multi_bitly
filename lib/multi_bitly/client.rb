module MultiBitly
  class Client
    class Error < StandardError; end

    def initialize(api_client=Bitly)
      @api_client = api_client
    end

    def shorten(url)
      account = account(url)
      api_response = client(account).shorten(url)
      response(account, api_response)
    end

    private

    attr_reader :api_client

    def account(url)
      Account.new(url)
    end

    def response(account, api_response)
      Response.new(account, api_response)
    end

    def client(account)
      @_client ||= api_client.new(account.username, account.api_key)
    rescue => exception
      raise Error.new("#{exception.class.to_s}: '#{exception.message}'")
    end
  end
end
