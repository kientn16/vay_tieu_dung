class AddAttachmentPathToMedia < ActiveRecord::Migration
  def self.up
    change_table :media do |t|
      t.attachment :path
    end
  end

  def self.down
    remove_attachment :media, :path
  end
end
