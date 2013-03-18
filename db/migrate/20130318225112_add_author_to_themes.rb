class AddAuthorToThemes < ActiveRecord::Migration
  def change
  	add_column :themes, :name, :string
  	add_column :themes, :price, :decimal, :precision => 8, :scale => 2
    add_column :themes, :author, :string
    add_column :themes, :lines_css, :integer
    add_column :themes, :picture_url, :string
  end
end
