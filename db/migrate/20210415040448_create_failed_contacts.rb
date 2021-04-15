class CreateFailedContacts < ActiveRecord::Migration[6.1]
  def change
    create_table :failed_contacts do |t|
      t.string "name"
      t.string "birthday"
      t.string "phone"
      t.string "address"
      t.string "credit_card"
      t.string "franchise"
      t.string "last_digits"
      t.string "email"
      t.text :error
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
