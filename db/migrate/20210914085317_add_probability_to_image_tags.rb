class AddProbabilityToImageTags < ActiveRecord::Migration[6.1]
  def change
    add_column :image_tags, :probability, :decimal
  end
end
