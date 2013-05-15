class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
        t.column :id, :string
        t.column :user_id, :string
        t.column :date_time, :datetime
        t.column :file_name, :string
    end
  end
end
