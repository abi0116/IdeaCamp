class AddAdoptedbyToIdeas < ActiveRecord::Migration[5.2]
  def change
    add_reference :ideas, :adopted_by,foreign_key: {to_table: :members }#既存のテーブルに外部キーを伴うカラムの追加
    add_column :ideas, :adopted_status, :integer,null: false,default: 0
  end
end
