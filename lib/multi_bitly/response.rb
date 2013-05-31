require 'delegate'

module MultiBitly
  class Response < SimpleDelegator
    attr_reader :account

    def initialize(account, response)
      @account = account
      super(response)
    end
  end
end
