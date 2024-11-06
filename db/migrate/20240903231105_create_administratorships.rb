class CreateAdministratorships < ActiveRecord::Migration[8.0]
  def change
    create_table :administratorships do |t|
      t.integer :role
      t.references :user, null: false, foreign_key: true
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end

    # add_index :administratorships, :user_id, unique: true
  end
end
