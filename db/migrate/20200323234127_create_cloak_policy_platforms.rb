class CreateCloakPolicyPlatforms < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_platforms do |t|
      t.string :name
      t.string :fqdn
      t.string :description
      t.string :icon
      t.string :platform_type
      t.string :they_say
      t.string :we_say
      t.boolean :recommendable

      t.timestamps
    end
  end
end
