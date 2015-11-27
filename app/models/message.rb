class Message < ActiveRecord::Base
  belongs_to :user, class_name: "LocalUser"
  belongs_to :chat, :inverse_of => :messages
end