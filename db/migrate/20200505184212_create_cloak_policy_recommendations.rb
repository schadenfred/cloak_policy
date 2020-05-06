class CreateCloakPolicyRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_recommendations do |t|
      t.string :name
      t.string :description
      t.integer :recommender_id

      t.timestamps
    end
    add_index :cloak_policy_recommendations, :recommender_id
  end
end
