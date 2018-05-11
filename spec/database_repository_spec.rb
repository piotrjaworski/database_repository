require 'spec_helper'

RSpec.describe DatabaseRepository do
  it 'has a version number' do
    expect(DatabaseRepository::VERSION).not_to be nil
  end
end
