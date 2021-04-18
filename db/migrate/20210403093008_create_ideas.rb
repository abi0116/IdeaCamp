class CreateIdeas < ActiveRecord::Migration[5.2]
  def change
    create_table :ideas do |t|
      t.integer :member_id,null: false
      t.string :title,null: false
      t.string :image_id,null: false
      t.text :caption,null: false
      t.boolean :is_adopted,null: false,default: false
      t.timestamps
    end
  end
end
