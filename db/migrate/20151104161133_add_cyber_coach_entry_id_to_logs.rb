class AddCyberCoachEntryIdToLogs < ActiveRecord::Migration
  def change
    add_column :logs, :cc_entry_id, :integer
  end
end
