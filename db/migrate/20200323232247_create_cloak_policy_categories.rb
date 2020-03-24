class CreateCloakPolicyCategories < ActiveRecord::Migration[6.0]
  def change
    create_table :cloak_policy_categories do |t|
      t.string :description
      t.string :icon
      t.string :name
      t.string :parent_type
      t.integer :parent_id
      t.integer :row_order
      t.string :category_type
      t.string :type

      t.timestamps
    end

    add_index :cloak_policy_categories, [:parent_id, :parent_type]
  end
end
