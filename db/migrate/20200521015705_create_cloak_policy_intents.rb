class CreateCloakPolicyIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_intents do |t|
      t.string :name
      t.text :description
      t.integer :weight
      t.integer :vector_id, null: false, foreign_key: true

      t.timestamps
    end
  end
end
