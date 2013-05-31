require 'spec_helper'

describe MultiBitly::AccountFinder do
  let(:account_finder) { MultiBitly::AccountFinder }
  let(:data_store) { BitlyAccount }
  let(:account1) {{ username: 'user1', api_key: 'key1' }}
  let(:account2) {{ username: 'user2', api_key: 'key2' }}

  before do
    set_configuration
  end

  describe '#account' do
    context 'with an unused account' do
      it 'gets the attributes for the account' do
        data_store.stub(:where).with(username: 'user1', url: 'example.com').and_return([])
        found_account = account_finder.new('example.com').account
        expect(found_account).to eq(account1)
      end
    end

    context 'with a used account' do
      it 'gets the attributes for the next available account' do
        data_store.stub(:where).with(username: 'user1', url: 'example.com').and_return([data_store])
        data_store.stub(:where).with(username: 'user2', url: 'example.com').and_return([])
        found_account = account_finder.new('example.com').account
        expect(found_account).to eq(account2)
      end
    end

    context 'without any available accounts' do
      it 'finds the last used account' do
        data_store.stub(:where).with(username: 'user1', url: 'example.com').and_return([data_store])
        data_store.stub(:where).with(username: 'user2', url: 'example.com').and_return([data_store])
        found_account = account_finder.new('example.com').account
        expect(found_account).to eq(account2)
      end
    end
  end
end
