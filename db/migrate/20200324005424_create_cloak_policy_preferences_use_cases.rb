class CreateCloakPolicyPreferencesUseCases < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_preferences_use_cases do |t|
      t.integer :use_case_id
      t.integer :preference_id

      t.timestamps
    end
  end
end
