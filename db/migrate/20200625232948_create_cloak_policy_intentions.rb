class CreateCloakPolicyIntentions < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_intentions do |t|
      t.string :intendable_type, null: false
      t.integer :intendable_id, null: false 
      t.integer :intent_id, null: false
      t.index [:intendable_type, :intendable_id], name: "index_cloak_policy_intendable"
      t.index ["intent_id"], name: "index_cloak_policy_intentions_on_intent_id"
      t.timestamps

    end
  end
end
