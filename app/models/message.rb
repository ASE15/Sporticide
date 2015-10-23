class Message < ActiveRecord::Base
  belongs_to :sender, class_name: "CyberUser"
  belongs_to :receiver, class_name: "CyberUser"
  belongs_to :chat, :inverse_of => :messages
end
