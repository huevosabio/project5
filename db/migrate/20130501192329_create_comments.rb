class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
        t.column :id, :string
        t.column :photo_id, :string
        t.column :user_id, :string
        t.column :date_time, :datetime
        t.column :comment, :string
    end
  end
end
