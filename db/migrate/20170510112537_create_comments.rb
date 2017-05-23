class CreateComments < ActiveRecord::Migration
  def change
  	create_table :comments do |t|
  		t.text :comment_body
  		t.integer :post_id
  		t.integer :user_id

  		t.timestamp
  	end
  end
end
