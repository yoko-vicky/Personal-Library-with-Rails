require 'rails_helper'

RSpec.describe 'Testing ImagesController', type: :request do
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

  describe 'Logged in user' do
    before do
      sign_in user
    end

    context 'Index (Show index view)' do
      before do
        get images_path
      end

      it 'Receive response status 200 OK' do
        expect(response.status).to eq 200
      end

      it 'Show title in root/images view' do
        expect(response.body).to include('Images')
      end
    end

    context 'Show (Show show view)' do
      before do
        get image_path(image1)
      end

      it 'Receive response status 200 OK' do
        expect(response.status).to eq 200
      end

      it 'Show title in view' do
        expect(response.body).to include(image1.name)
      end
    end
  end

  describe 'Not logged in' do
    context 'Not show index view' do
      before do
        get images_path
      end

      it 'Receive response status 302 to get redirect to the signin view' do
        expect(response.status).to eq 302
      end
    end
  end
end
