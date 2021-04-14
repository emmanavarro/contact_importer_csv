class AddLastDigitsToContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :last_digits, :string
  end
end
