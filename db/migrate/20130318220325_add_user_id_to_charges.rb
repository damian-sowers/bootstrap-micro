class AddUserIdToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :user_id, :integer
    add_column :charges, :stripe_customer_id, :integer
    add_column :charges, :amount_paid, :decimal, :precision => 8, :scale => 2
    add_column :charges, :theme_id, :integer
    add_column :charges, :theme_name, :string
  end
end
