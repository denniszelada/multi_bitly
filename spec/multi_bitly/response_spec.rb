require 'spec_helper'

describe MultiBitly::Response do
  let(:responder) { MultiBitly::Response }

  it 'delegates to the underlying response' do
    account = stub(:account)
    response = stub(:response, a_method: 'underlying method')
    expect(responder.new(account, response).a_method).to eq('underlying method')
  end

  it 'sets the account' do
    account = stub(:account)
    expect(responder.new(account, stub).account).to eq(account)
  end
end
