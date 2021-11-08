require 'rails_helper'

RSpec.describe ImageTag, type: :model do
  describe 'Testing associations' do
    it { should belong_to(:image) }
    it { should belong_to(:tag) }
  end
end
