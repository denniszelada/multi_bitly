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
  end

  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield configuration
  end
end
