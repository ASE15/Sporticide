class Message < ActiveRecord::Base
  belongs_to :user, class_name: "LocalUser"
  belongs_to :chat, :inverse_of => :messages


  validates :text, :length => { :minimum => 1 }, allow_nil: false, allow_blank: false
end