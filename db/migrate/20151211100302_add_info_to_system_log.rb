class AddInfoToSystemLog < ActiveRecord::Migration
  def change
    add_column :system_logs, :info, :string
  end
end
