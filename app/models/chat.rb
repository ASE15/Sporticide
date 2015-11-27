class Chat < ActiveRecord::Base
  belongs_to :user, class_name: 'LocalUser'
  belongs_to :partner, class_name: 'LocalUser'
  has_many :messages, :inverse_of => :chat, :dependent => :destroy

  scope :involving, ->(user) do
    where("chats.user_id =? OR chats.partner_id =?",user.id,user.id)
  end

  scope :between, ->(sender_id,recipient_id) do
    where("(chats.user_id = ? AND chats.partner_id =?) OR (chats.user_id = ? AND chats.partner_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end

  def get_partner(user)
    if self.user == user
      self.partner
    else
      self.user
    end
  end

  def unread?(user)
    if self.user == user
      not self.userRead
    elsif self.partner == user
      not self.partnerRead
    end
  end

  def mark_as_read(user)
    if self.user == user
      self.userRead = true
    elsif self.partner == user
      self.partnerRead = true
    end
  end

  def get_last_message
    if self.messages.count > 0
      return self.messages.last
    end
    return nil
  end

  def unread_partner_of(user)
    if self.user == user
      self.partnerRead = false
    elsif self.partner == user
      self.userRead = false
    end
  end
end