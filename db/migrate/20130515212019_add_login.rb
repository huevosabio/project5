class AddLogin < ActiveRecord::Migration
  def change
      add_column :users, :login, :string
      User.all.each do |user|
          user.update_attributes!(:login => user.last_name.downcase)
      end
  end

end
