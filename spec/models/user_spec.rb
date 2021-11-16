require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Testing associations' do
    it { should have_many(:images).dependent(:destroy) }
    it { should have_many(:tags).dependent(:destroy) }
    it { should have_many(:users).dependent(:destroy) }
  end

  describe 'Testing scopes and instance methods' do
    let!(:user) { User.create(email: 'user1@test.com', password: 'pass123') }
    let!(:tag1) { user.tags.create(name: 'Colors') }
    let!(:tag2) { user.tags.create(name: 'Fruits') }
    let!(:tag3) { user.tags.create(name: 'Places') }
    let!(:image1) { user.images.create(name: 'Apple', file: 'apple.png') }
    let!(:image2) { user.images.create(name: 'Blue', file: 'blue.png') }
    let!(:image3) { user.images.create(name: 'Zoo', file: 'zoo.png') }
    let!(:image_tag1) { ImageTag.create(image_id: image1.id, tag_id: tag2.id) }
    let!(:image_tag2) { ImageTag.create(image_id: image2.id, tag_id: tag1.id) }
    let!(:image_tag3) { ImageTag.create(image_id: image3.id, tag_id: tag3.id) }

    describe 'images_sort_by' do
      it 'returns images of the User sorted by the order based on the argument string' do
        expect(user.images_sort_by('asc').first.name).to eq 'Apple'
        expect(user.images_sort_by('desc').first.name).to eq 'Zoo'
      end
    end

    describe 'tags_sort_by' do
      it 'returns tags of the User sorted by the order based on the argument string' do
        expect(user.tags_sort_by('asc').first.name).to eq 'Colors'
        expect(user.tags_sort_by('desc').first.name).to eq 'Places'
      end
    end

    describe 'images_search_by' do
      it 'returns images of the User searched by the the keyword passed as an argument' do
        expect(user.images_search_by('blue').first.name).to eq 'Blue'
        expect(user.images_search_by('apple').first.name).to eq 'Apple'
      end
    end

    describe 'tags_search_by' do
      it 'returns tags of the User searched by the the keyword passed as an argument' do
        expect(user.tags_search_by('color').first.name).to eq 'Colors'
        expect(user.tags_search_by('fruit').first.name).to eq 'Fruits'
      end
    end
  end
end
