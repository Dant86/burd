class CreatePosts < ActiveRecord::Migration
  def change
  	create_table :posts do |t|
  		t.string :post_img_url
  		t.text :post_body
  		t.integer :user_id

  		t.timestamp
  	end
  end
end
