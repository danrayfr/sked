class CreatePatientRecords < ActiveRecord::Migration[8.0]
  def change
    create_table :patient_records do |t|
      t.string :name, null: false
      t.string :email_address, null: false
      t.datetime :date, null: false
      t.string :procedure
      t.references :organization, null: false, foreign_key: true

      t.timestamps
    end
  end
end
