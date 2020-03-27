class CreateCloakPolicyVectors < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_vectors do |t|
      t.string :description
      t.string :icon
      t.string :name
      t.integer :parent_id
    end
  end
end
