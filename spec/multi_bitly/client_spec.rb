require 'spec_helper'

describe MultiBitly::Client do
  let(:client) { MultiBitly::Client }
  let(:api_client) { ApiClient }

  before do
    set_configuration
  end

  context '#shorten' do
    it 'delegates to the underlying client with an account' do
      instance = client.new(api_client)
      expect(instance.shorten('http://google.com').user_hash).to eq('g123')
    end

    context 'when the underlying client raises an exception' do
      let(:account) { stub(:account, username: nil, api_key: nil) }

      before do
        api_client.stub(:new).and_raise(StandardError, 'api error')
      end

      it 'rescues and reraises the exception' do
        instance = client.new(api_client)
        expect {
          instance.shorten('http://google.com')
        }.to raise_error(MultiBitly::Client::Error, "StandardError: 'api error'")
      end
    end
  end
end
