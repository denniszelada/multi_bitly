require 'spec_helper'

describe MultiBitly::Account do
  let(:account) { MultiBitly::Account }

  before do
    set_configuration
  end

  describe '#username' do
    it 'gets the username from the found account' do
      found_account = account.new('example.com')
      expect(found_account.username).to eq('user1')
    end
  end

  describe '#api_key' do
    it 'gets the api key from the found account' do
      found_account = account.new('example.com')
      expect(found_account.api_key).to eq('key1')
    end
  end
end
