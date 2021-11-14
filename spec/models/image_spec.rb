require 'rails_helper'

RSpec.describe Image, type: :model do
  describe 'Testing validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Testing associations' do
    it { should have_many(:image_tags) }
    it { should have_many(:tags).through(:image_tags) }
    it { should belong_to(:user) }
  end

  describe 'Testing scopes and instance methods' do
    let!(:user) { User.create(email: 'user1@test.com', password: 'pass123') }
    let!(:image_apple) { user.images.create(name: 'Apple', file: 'apple.png') }
    let!(:image_banana) { user.images.create(name: 'Banana', file: 'banana.png') }
    let!(:image_pine) { user.images.create(name: 'Pineapple', file: 'pine.png') }
    let!(:image_zoo) { user.images.create(name: 'Zoo', file: 'zoo.png') }

    describe 'sort_by_name_asc' do
      it 'returns Image sorted by ASC name order' do
        expect(user.images.sort_by_name_asc.first.name).to eq 'Apple'
      end
    end

    describe 'sort_by_name_desc' do
      it 'returns Image sorted by DESC name order' do
        expect(user.images.sort_by_name_desc.first.name).to eq 'Zoo'
      end
    end

    describe 'search_by' do
      it 'returns Image searched by the keyword passed as an argument' do
        expect(user.images.search_by('apple').first.name).to eq 'Apple'
        expect(user.images.search_by('apple').second.name).to eq 'Pineapple'
      end
    end

    describe 'sort_by_order' do
      it 'return image sorted by the order passed as an argument' do
        expect(user.images.sort_by_order('asc').first.name).to eq 'Apple'
        expect(user.images.sort_by_order('desc').first.name).to eq 'Zoo'
      end
    end
  end
end


# def self.add_pagenation(param)
#     page(param).per(10)
#   end

#   def self.sort_by_order(order)
#     order == 'desc' ? sort_by_name_desc : sort_by_name_asc
#   end
