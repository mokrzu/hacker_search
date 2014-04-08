class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.string :author
      t.integer :points
      t.text :content
      t.integer :comments_count
      t.integer :source_id

      t.timestamps
    end
  end
end
