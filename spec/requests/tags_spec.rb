require 'rails_helper'

RSpec.describe 'Testing TagsController', type: :request do
  let!(:user) { User.create(email: 'user1@test.com', password: 'pass123') }
  let!(:tag1) { user.tags.create(name: 'Colors') }
  let!(:image2) { user.images.create(name: 'Blue', file: 'blue.png') }
  let!(:image_tag2) { ImageTag.create(image_id: image2.id, tag_id: tag1.id) }

  describe 'Logged in user' do
    before do
      sign_in user
    end

    context 'GET /tags/' do
      before do
        get tags_path
      end

      it 'Receive response status 200 OK' do
        expect(response.status).to eq 200
      end

      it 'Show title in root/tags view' do
        expect(response.body).to include('tags')
      end
    end

    context 'GET /tag/:id/' do
      before do
        get tag_path(tag1)
      end

      it 'Receive response status 200 OK' do
        expect(response.status).to eq 200
      end

      it 'Show title in view' do
        expect(response.body).to include(tag1.name)
      end
    end

    context 'POST /tags/' do
      let(:valid_params) { { tag: { name: 'popcorn', user_id: user.id } } }

      context 'when the request is valid' do
        before do
          post tags_path, params: valid_params
        end

        it 'creates a tag' do
          expect(response.body).not_to be_empty
        end

        it 'returns status code 302 to redirect to show view' do
          expect(response.status).to eq 302
        end
      end

      context 'when the request is invalid' do
        before do
          post tags_path, params: { tag: { name: '' } }
        end

        it 'returns status code 422' do
          expect(response.status).to eq 422
        end
      end
    end

    context 'PUT /tag/:id/' do
      let(:valid_params) { { tag: { name: 'New Colors' } } }

      context 'when the request is valid' do
        before do
          put tag_path(tag1), params: valid_params
        end

        it 'creates a tag' do
          expect(response.body).not_to be_empty
        end

        it 'returns status code 302 to redirect to show view' do
          expect(response.status).to eq 302
        end
      end

      context 'when the request is invalid' do
        before do
          put tag_path(tag1), params: { tag: { name: '' } }
        end

        it 'returns status code 422' do
          expect(response.status).to eq 422
        end
      end
    end

    context 'DELETE /tags/:id' do
      before do
        delete tag_path(tag1)
      end

      it 'Receive response status 302 to redirect to index view' do
        expect(response.status).to eq 302
      end
    end
  end

  describe 'Not logged in' do
    context 'Not show index view' do
      before do
        get tags_path
      end

      it 'Receive response status 302 to get redirect to the signin view' do
        expect(response.status).to eq 302
      end
    end
  end
end
