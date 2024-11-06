class CreateOrganizations < ActiveRecord::Migration[8.0]
  def change
    create_table :organizations do |t|
      t.string :name, null: false
      t.string :slug, null: false
      t.boolean :active, default: true
      t.string :uid, null: false
      t.string :join_code, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :organizations, :name, unique: true
    add_index :organizations, :uid, unique: true
    add_index :organizations, :slug, unique: true
    add_index :organizations, :join_code, unique: true
  end
end
