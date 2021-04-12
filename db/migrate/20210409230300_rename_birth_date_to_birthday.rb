class RenameBirthDateToBirthday < ActiveRecord::Migration[6.1]
  def change
    rename_column :contacts, :birth_date, :birthday
  end
end
