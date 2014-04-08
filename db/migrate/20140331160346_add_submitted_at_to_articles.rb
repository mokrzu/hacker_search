class AddSubmittedAtToArticles < ActiveRecord::Migration
  def up
    add_column :articles, :submitted_at, :datetime
  end

  def down
    remove_column :articles, :submitted_at
  end
end
