class Chat < ActiveRecord::Base
  belongs_to :user, class_name: 'LocalUser'
  belongs_to :partner, class_name: 'LocalUser'
  has_many :messages, :inverse_of => :chat, :dependent => :destroy
end
