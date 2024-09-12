class CreateServices < ActiveRecord::Migration[8.0]
  def change
    create_table :services do |t|
      t.string :name
      t.text :description
      t.float :cost
      t.bigint :organization_id, null: false

      t.timestamps
      t.index [ "organization_id" ], name: "index_services_on_organization_id"
    end
  end
end
