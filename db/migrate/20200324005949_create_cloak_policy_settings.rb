class CreateCloakPolicySettings < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_settings do |t|
      t.string :name
      t.string :edit_url
      t.integer :platform_id
      t.integer :row_order
      t.boolean :recommendable
      t.string :they_say
      t.string :we_say
      t.string :page

      t.timestamps
    end
    add_index :cloak_policy_settings, :platform_id
  end
end
