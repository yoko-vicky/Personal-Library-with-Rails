require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  let!(:user) { User.create(email: 'user1@test.com', password: 'pass123') }
  let!(:tag1) { user.tags.create(name: 'Colors') }
  let!(:image2) { user.images.create(name: 'Blue', file: 'blue.png') }
  let!(:image_tag2) { ImageTag.create(image_id: image2.id, tag_id: tag1.id) }

  describe 'tag_images_num' do
    it 'returns images number based on the tag passed as an argument' do
      expect(tag_images_num(tag1)).to eq 1
    end
  end
end
