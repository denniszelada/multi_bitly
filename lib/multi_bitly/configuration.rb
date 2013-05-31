module MultiBitly
  class Configuration
    attr_accessor :accounts,
                  :data_store

    def initialize
      @accounts = []
    end

    def data_store
      @data_store ||= ::BitlyAccount
    end

    def accounts
      symbolize_account_keys
    end

    private

    def symbolize_account_keys
      @accounts.map { |account|
        account.each_with_object({}) { |key_value, hsh|
          hsh[key_value[0].to_sym.downcase] = key_value[1]
        }
      }
    end
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end
end
