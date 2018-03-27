require 'rails_helper'

describe 'Client' do
  it 'returns false for client without username' do
    client = Client.new(password: 'superpass')

    expect(client).not_to be_valid
  end

  it 'returns false for client without password' do
    client = Client.new(username: 'Yoda')

    expect(client).not_to be_valid
  end

  it 'returns true for valid client' do
    client = Client.new(username: 'Yoda', password: 'superpass')

    expect(client).to be_valid
  end
end
