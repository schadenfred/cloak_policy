class CreateCloakPolicySettings < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_settings do |t|
      t.string :name
      t.integer :platform_id
      t.integer :row_order
      t.string :page
      t.string :edit_url
      t.string :they_say
      t.string :we_say
      t.boolean :recommendable

      t.timestamps
    end
  end
end
