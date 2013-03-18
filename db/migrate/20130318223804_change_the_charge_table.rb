class ChangeTheChargeTable < ActiveRecord::Migration
  def up
  	change_column :charges, :stripe_customer_id, :string
  end

  def down
  	change_column :charges, :stripe_customer_id, :integer
  end
end
