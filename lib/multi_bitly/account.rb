module MultiBitly
  class Account
    def initialize(url)
      @url = url
    end

    def username
      finder.new(url).account[:username]
    end

    def api_key
      finder.new(url).account[:api_key]
    end

    private

    attr_reader :url

    def finder
      AccountFinder
    end
  end
end
