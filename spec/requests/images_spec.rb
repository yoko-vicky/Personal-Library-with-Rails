require 'rails_helper'

RSpec.describe 'Testing ImagesController', type: :request do
  let!(:user) { User.create(email: 'user1@test.com', password: 'pass123') }
  let!(:tag2) { user.tags.create(name: 'Fruits') }
  let!(:image1) { user.images.create(name: 'Apple', file: 'apple.png') }
  let!(:image_tag1) { ImageTag.create(image_id: image1.id, tag_id: tag2.id) }

  describe 'Logged in user' do
    before do
      sign_in user
    end

    context 'GET /images/' do
      before do
        get images_path
      end

      it 'Receive response status 200 OK' do
        expect(response.status).to eq 200
      end

      it 'Show title in index view' do
        expect(response.body).to include('images')
      end
    end

    context 'GET /image/:id/' do
      before do
        get image_path(image1)
      end

      it 'Receive response status 200 OK' do
        expect(response.status).to eq 200
      end

      it 'Show title in show view' do
        expect(response.body).to include(image1.name)
      end
    end

    context 'POST /images/' do
      let(:valid_params) { { image: { name: 'Cute Cat', file: 'cat.png', user_id: user.id }, format: :js } }

      context 'when the request is valid' do
        before do
          post images_path, params: valid_params, xhr: true
        end

        it 'send a request to API and pass back data to controller' do
          expect(response.body).to include 'fetch'
          expect(response.body).to include '$.ajax'
        end

        it 'returns status code 200 to redirect to show view' do
          expect(response.status).to eq 200
        end
      end

      context 'when the request is invalid' do
        before do
          post images_path, params: { image: { name: '', file: '' }, format: :js }
        end

        it 'redirects to index view' do
          expect(response.body).to include 'window.location.replace'
        end
      end
    end

    context 'PUT /image/:id/' do
      let(:valid_params) { { image: { name: 'Beautiful Cat' } } }

      context 'when the request is valid' do
        before do
          put image_path(image1), params: valid_params
        end

        it 'updates a image' do
          expect(response.body).not_to be_empty
        end

        it 'returns status code 302 to redirect to show view' do
          expect(response.status).to eq 302
        end
      end

      context 'when the request is invalid' do
        before do
          put image_path(image1), params: { image: { name: '' } }
        end

        it 'returns status code 422' do
          expect(response.status).to eq 422
        end
      end
    end

    context 'DELETE /image/:id' do
      before do
        delete image_path(image1)
      end

      it 'Receive response status 302 to redirect to index view' do
        expect(response.status).to eq 302
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
