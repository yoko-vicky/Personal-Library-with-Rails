require 'rails_helper'

RSpec.describe Tag, type: :model do
  describe 'Testing validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'Testing associations' do
    it { should have_many(:image_tags).dependent(:destroy) }
    it { should have_many(:images).through(:image_tags) }
    it { should belong_to(:user) }
  end

  describe 'Testing scopes and instance methods' do
    let!(:user) { User.create(email: 'user1@test.com', password: 'pass123') }
    let!(:tag1) { user.tags.create(name: 'Colors') }
    let!(:tag2) { user.tags.create(name: 'Fruits') }
    let!(:tag3) { user.tags.create(name: 'Places') }
    let!(:image1) { user.images.create(name: 'Apple', file: 'apple.png') }
    let!(:image2) { user.images.create(name: 'Blue', file: 'blue.png') }
    let!(:image3) { user.images.create(name: 'Zoo', file: 'zoo.png') }
    let!(:image_tag1) { user.image_tags.create(image_id: image1.id, tag_id: tag2.id) }
    let!(:image_tag2) { user.image_tags.create(image_id: image2.id, tag_id: tag1.id) }
    let!(:image_tag3) { user.image_tags.create(image_id: image3.id, tag_id: tag3.id) }

    describe 'sort_by_name_asc' do
      it 'returns Tags sorted by ASC name order' do
        expect(user.tags.sort_by_name_asc.first.name).to eq 'Colors'
      end
    end

    describe 'sort_by_name_desc' do
      it 'returns Tags sorted by DESC name order' do
        expect(user.tags.sort_by_name_desc.first.name).to eq 'Places'
      end
    end

    describe 'search_by' do
      it 'returns Tags searched by the keyword passed as an argument' do
        expect(user.tags.search_by('fruit').first.name).to eq 'Fruits'
      end
    end

    describe 'names_downcased' do
      it 'returns Tag that only includes downcased tag names' do
        expect(user.tags.names_downcased.first).to eq 'colors'
      end
    end

    describe 'images_sort_by' do
      it 'returns images of the Tag sorted by the order based on the argument string' do
        expect(tag1.images_sort_by('asc').first.name).to eq 'Blue'
        expect(tag2.images_sort_by('desc').first.name).to eq 'Apple'
      end
    end

    describe 'images_search_by' do
      it 'returns images of the Tag searched by the the keyword passed as an argument' do
        expect(tag1.images_search_by('blue').first.name).to eq 'Blue'
        expect(tag2.images_search_by('apple').first.name).to eq 'Apple'
      end
    end

    describe 'sort_by_order' do
      it 'return tags image sorted by the order passed as an argument' do
        expect(user.tags.sort_by_order('asc').first.name).to eq 'Colors'
        expect(user.tags.sort_by_order('desc').first.name).to eq 'Places'
      end
    end
  end
end
