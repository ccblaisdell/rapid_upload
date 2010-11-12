class RemovePaperclipFromImages < ActiveRecord::Migration
  def self.up
    remove_column :images, :avatar_file_name
    remove_column :images, :avatar_content_type
    remove_column :images, :avatar_file_size
    remove_column :images, :avatar_updated_at
  end

  def self.down
    add_column :images, :avatar_file_name,    :string
    add_column :images, :avatar_content_type, :string
    add_column :images, :avatar_file_size,    :integer
    add_column :images, :avatar_updated_at,   :datetime
  end
end
