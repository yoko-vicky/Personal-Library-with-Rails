require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ImagesHelper. For example:
#
# describe ImagesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ImagesHelper, type: :helper do
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

  describe 'file_size' do
    it 'returns file size converted to kb unit' do
      expect(file_size(image1)).to eq 0
    end
  end

  describe 'image_tags_list' do
    it 'returns tags name list based on the image passed as an argument' do
      expect(image_tags_list(image1).first).to eq 'Fruits'
    end
  end

  describe 'image_tags_num' do
    it 'returns tags number based on the image passed as an argument' do
      expect(image_tags_num(image1)).to eq 1
    end
  end

  describe 'all_images_num' do
    it 'returns the number of images based on the images passed as an argument' do
      expect(all_images_num(user.images)).to eq 3
    end
  end
end
