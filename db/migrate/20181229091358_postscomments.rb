class Postscomments < ActiveRecord::Migration[5.2]
  def change
  	create_table :Posts do |t|
    	t.text :content
    	t.text :name
    	t.timestamps
  	end	
  	create_table :Comments do |tt|
    	tt.text :content
    	tt.integer :post_id
    	tt.timestamps
  	end	
  end
end
