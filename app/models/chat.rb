class Chat < ActiveRecord::Base
  belongs_to :cyber_user
  belongs_to :partner, class_name: 'CyberUser'
  has_many :messages, :inverse_of => :chat, :dependent => :destroy
end
