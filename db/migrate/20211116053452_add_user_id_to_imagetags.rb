class AddUserIdToImagetags < ActiveRecord::Migration[6.1]
  def change
    add_reference :image_tags, :user, foreign_key: true
  end
end
