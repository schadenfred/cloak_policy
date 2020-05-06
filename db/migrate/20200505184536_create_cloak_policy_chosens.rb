class CreateCloakPolicyChosens < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_chosens do |t|
      t.integer :choice_id
      t.integer :recommendation_id
      t.string :advice

      t.timestamps
    end
    add_index :cloak_policy_chosens, :choice_id
    add_index :cloak_policy_chosens, :recommendation_id
  end
end
