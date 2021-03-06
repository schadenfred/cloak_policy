class CreateCloakPolicyScores < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_scores do |t|
      t.string :scorable_type
      t.integer :scorable_id
      t.integer :vector_id
      t.string :impact
      t.integer :weight, default: 100

      t.timestamps
    end

    add_index :cloak_policy_scores, [:scorable_type, :scorable_id]

  end
end
