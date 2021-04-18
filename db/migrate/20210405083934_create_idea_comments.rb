class CreateIdeaComments < ActiveRecord::Migration[5.2]
  def change
    create_table :idea_comments do |t|
      t.integer :member_id,null: false
      t.integer :idea_id,null: false
      t.text :comment,null: false

      t.timestamps
    end
  end
end
