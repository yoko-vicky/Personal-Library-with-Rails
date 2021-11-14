require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  it { should use_before_action(:set_tag) }
end
