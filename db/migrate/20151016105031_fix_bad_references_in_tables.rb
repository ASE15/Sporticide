class FixBadReferencesInTables < ActiveRecord::Migration
  def change
    remove_reference :trainings, :session, index:true
    remove_reference :trainings, :comment, index:true

    add_reference :training_sessions, :training, index:true
    add_reference :comments, :training, index:true
    add_reference :logs, :training, index:true
    add_reference :messages, :chat, index:true
  end
end
