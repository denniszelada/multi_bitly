require 'spec_helper'

describe MultiBitly::Configuration do
  describe '#accounts' do
    context 'when set' do
      context 'with keys of symbols' do
        before do
          MultiBitly::configure do |config|
            config.accounts = [
              { username: 'user1', api_key: 'key1' },
              { username: 'user2', api_key: 'key2' }
            ]
          end
        end

        after do
          MultiBitly.configuration = nil
        end

        it 'uses the supplied accounts' do
          expect(MultiBitly.configuration.accounts).to eq([
            { username: 'user1', api_key: 'key1' },
            { username: 'user2', api_key: 'key2' }
          ])
        end
      end

      context 'with capitalized keys' do
        before do
          MultiBitly::configure do |config|
            config.accounts = [
              { 'USERNAME' => 'user1', 'API_KEY' => 'key1' },
              { 'USERNAME' => 'user2', 'API_KEY' => 'key2' }
            ]
          end
        end

        after do
          MultiBitly.configuration = nil
        end

        it 'uses the supplied accounts' do
          expect(MultiBitly.configuration.accounts).to eq([
            { username: 'user1', api_key: 'key1' },
            { username: 'user2', api_key: 'key2' }
          ])
        end
      end
    end

    context 'when not set' do
      before do
        MultiBitly::configure do |config|
        end
      end

      it 'is an empty list' do
        expect(MultiBitly.configuration.accounts).to eq([])
      end
    end
  end

  describe '#data_store' do
    context 'when set' do
      let(:data_store) { stub(:data_store) }

      before do
        MultiBitly::configure do |config|
          config.data_store = data_store
        end
      end

      after do
        MultiBitly.configuration = nil
      end

      it 'uses the supplied data store' do
        expect(MultiBitly.configuration.data_store).to eq(data_store)
      end
    end

    context 'when not set' do
      before do
        MultiBitly::configure do |config|
        end
      end

      it 'sets a default' do
        expect(MultiBitly.configuration.data_store).to eq(BitlyAccount)
      end
    end
  end
end
