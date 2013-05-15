class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
        t.column :id, :string
        t.column :first_name, :string
        t.column :last_name, :string
    end
  end
end
