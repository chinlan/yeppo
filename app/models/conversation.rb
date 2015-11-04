

class Conversation < ActiveRecord::Base
  belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
  belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

  has_many :messages, dependent: :destroy

  validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id, recipient_id) do
    where("(conversations.sender_id = ? AND conversations.recipient_id = ? ) OR (conversations.sender_id = ? AND conversations.recipient_id = ? )",
      sender_id, recipient_id, recipient_id, sender_id )    
  end

  def self.get(user1, user2)
    where("(conversations.sender_id = ? AND conversations.recipient_id = ? ) OR (conversations.sender_id = ? AND conversations.recipient_id = ? )",
      user1, user2, user2, user1 ).first
  end

  def self.get_mine(user_id)
    where("sender_id = ? OR recipient_id = ?", user_id, user_id)
  end

  def find_last_to_me_message(u)
    self.messages.where.not( :user_id=> u.id ).order("id DESC").first
  end

end
