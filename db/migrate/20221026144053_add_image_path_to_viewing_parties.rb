class AddImagePathToViewingParties < ActiveRecord::Migration[5.2]
  def change
    add_column :viewing_parties, :image_path, :string
  end
end
