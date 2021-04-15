class AddColumnsToImportFiles < ActiveRecord::Migration[6.1]
  def change
    add_column :import_files, :filename, :string
    add_column :import_files, :status, :string
  end
end
