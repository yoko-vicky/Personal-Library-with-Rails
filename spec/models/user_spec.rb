require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Testing associations' do
    it { should have_many(:images).dependent(:destroy) }
  end
end
