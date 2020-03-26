class CreateCloakPolicyChosens < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_chosens do |t|
      t.string :advice
      t.integer :choice_id
      t.integer :recommendation_id
      t.integer :setting_id
      t.boolean :recommendable

      t.timestamps
    end
    add_index :cloak_policy_chosens, :choice_id
    add_index :cloak_policy_chosens, :recommendation_id
    add_index :cloak_policy_chosens, :setting_id
  end
end
