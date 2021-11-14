require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Testing associations' do
    it { should have_many(:image_tags).dependent(:destroy) }
    it { should have_many(:images).through(:image_tags) }
    it { should belong_to(:user) }
  end
end
