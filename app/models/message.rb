class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "LocalUser"
  belongs_to :receiver, class_name: "LocalUser"
  belongs_to :chat, :inverse_of => :messages
end
