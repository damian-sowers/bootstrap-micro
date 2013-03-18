class AddDownloadUrlToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :download_url, :string
  end
end
