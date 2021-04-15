class RemoveColumnFromImportFiles < ActiveRecord::Migration[6.1]
  def change
    remove_column :import_files, :status, :string
  end
end
