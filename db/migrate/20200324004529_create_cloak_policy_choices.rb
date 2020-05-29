class CreateCloakPolicyChoices < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_choices do |t|
      t.string :name
      t.string :value
      t.integer :setting_id
      t.integer :weight
      t.string :we_say
      t.string :they_say
      t.boolean :recommendable

      t.timestamps
    end
  end
end
