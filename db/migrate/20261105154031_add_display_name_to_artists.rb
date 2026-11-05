class AddDisplayNameToArtists < ActiveRecord::Migration[8.1]
  def change
    add_column :artists, :display_name, :json, null: false, default: {}
  end
end
