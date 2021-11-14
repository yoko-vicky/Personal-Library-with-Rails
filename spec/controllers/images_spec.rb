require 'rails_helper'

RSpec.describe ImagesController, type: :controller do
  it { should use_before_action(:set_image) }
end
