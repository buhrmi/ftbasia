class AddMetadataToActiveStorageAttachments < ActiveRecord::Migration[8.1]
  def change
    add_column :active_storage_attachments, :alt_text, :json, null: false, default: {}
    add_column :active_storage_attachments, :caption, :json, null: false, default: {}
    add_column :active_storage_attachments, :credit, :string
    add_column :active_storage_attachments, :position, :integer, null: false, default: 0
    add_column :active_storage_attachments, :custom_metadata, :json, null: false, default: {}
  end
end
