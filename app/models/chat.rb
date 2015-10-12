class Chat < ActiveRecord::Base
  belongs_to :user
  belongs_to :partner, class_name: 'User'
  has_many :messages, :inverse_of => :chat, :dependant => :destroy
end
