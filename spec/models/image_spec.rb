require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Testing associations' do
    it { should have_many(:image_tags) }
    it { should have_many(:tags).through(:image_tags) }
    it { should belong_to(:user) }
  end
end
