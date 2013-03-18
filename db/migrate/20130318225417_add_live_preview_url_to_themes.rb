class AddLivePreviewUrlToThemes < ActiveRecord::Migration
  def change
    add_column :themes, :live_preview_url, :string
  end
end
