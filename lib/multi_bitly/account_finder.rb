module MultiBitly
  class AccountFinder
    def initialize(url)
      @url = url
      @accounts = MultiBitly.configuration.accounts
      @data_store = MultiBitly.configuration.data_store
    end

    def account
      last_account = nil

      accounts.each do |account|
        found_account = existing_account(account)
        if found_account.empty?
          return account
        else
          last_account = account
        end
      end
      last_account
    end

    private

    attr_reader :url,
                :accounts,
                :data_store

    def existing_account(account)
      data_store.where(username: account[:username], url: url)
    end
  end
end
