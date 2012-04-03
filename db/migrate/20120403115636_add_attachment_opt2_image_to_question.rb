class AddAttachmentOpt2ImageToQuestion < ActiveRecord::Migration
  def self.up
    add_column :questions, :opt2_image_file_name, :string
    add_column :questions, :opt2_image_content_type, :string
    add_column :questions, :opt2_image_file_size, :integer
    add_column :questions, :opt2_image_updated_at, :datetime
  end

  def self.down
    remove_column :questions, :opt2_image_file_name
    remove_column :questions, :opt2_image_content_type
    remove_column :questions, :opt2_image_file_size
    remove_column :questions, :opt2_image_updated_at
  end
end
