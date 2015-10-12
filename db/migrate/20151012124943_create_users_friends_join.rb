class CreateUsersFriendsJoin < ActiveRecord::Migration
  def self.up
    create_table 'friends', :force => true, :id => false  do |t|
      t.column 'user_a_id', :integer, :null => false
      t.column 'user_b_id', :integer, :null => false
    end
  end

  def self.down
    drop_table 'friends'
  end
end