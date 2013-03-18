class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|

      t.timestamps
    end
  end
end
