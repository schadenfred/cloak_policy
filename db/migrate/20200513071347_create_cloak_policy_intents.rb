class CreateCloakPolicyIntents < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_intents do |t|
      t.references :intendable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
