class CreateAccesses < ActiveRecord::Migration[8.0]
  def change
    create_table :accesses do |t|
      t.string :level, null: false
      t.integer :user_id, null: false
      t.integer :patient_record_id, null: false
      t.timestamps
      t.index [ "patient_record_id" ], name: "index_accesses_on_patient_record_id"
      t.index [ "user_id" ], name: "index_accesses_on_user_id"
      t.index [ "user_id", "patient_record_id" ], name: "index_accesses_on_user_id_and_patient_record_id", unique: true
    end
  end
end
