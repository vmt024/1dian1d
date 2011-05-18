class Message < ActiveRecord::Base
  belongs_to :user
  
  def self.my_private_messages(user_id,option={:unread_only=>false})
    if option[:unread_only]
      return Message.where("receiver_id = ? and read_yn = ?",user_id,false)
    else
      return Message.where("receiver_id = ?",user_id)
    end 
  end  

  private
  def self.unread_message_count(user_id)
    return Message.count("receiver_id = ? and read_yn = ?",user_id,false)
  end

  def self.messages_sent_to(user_id)
    return Message.where("receiver_id = ?",user_id)
  end

  def self.messages_sent_from(user_id)
    return Message.where("sender_id = ?",user_id)
  end

  def self.send_message(option={})
    message = {:sender_id=>option[:from],:receiver_id=>option[:to],:content=>option[:content]}
    Message.create(message)
  end
  
  def self.reply_to_this_message(option={})
    original_message = Message.find_by_id(option[:reply_to_id])
    reply_message = {:from=>original_message.receiver_id,
		     :to=>original_message.sender_id,
                     :content=>option[:reply]}
    Message.send_message(reply_message)
  end
end
