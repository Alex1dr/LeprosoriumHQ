class CreateComments < ActiveRecord::Migration[6.0]
  def change
    create_table :comments do |t|
      t.text :name
      t.text :content
      t.text :post_id

      t.timestamps
    end
  end
end
