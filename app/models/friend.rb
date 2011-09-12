class Friend < ActiveRecord::Base

  # return friend's user name
  def name
    return User.exists?(["id = ?",self.user_id]) ? User.find(self.user_id).name : ""
  end
  
  # list all friends for the given user_id
  def self.my_friends(user_id)
    return Friend.where("user_id = ?",user_id)
  end

  # list all fans for the given user_id
  def self.my_fans(user_id)
    return Friend.where("friend_id = ?",user_id)
  end

  # user 2 is user 1's friend
  def self.is_my_friend?(user1,user2)
    return Friend.exists?(["user_id = ? and friend_id = ?",user1,user2])
  end

  # return true if user1 and user2 or fans and friends for each other
  def self.are_they_friend?(user1,user2)
    return Friend.exists?(["(user_id = ? and friend_id = ?) or (user_id = ? and friend_id = ?)",user1,user2,user2,user1])
  end
  
  # return true if user1 and user2 and fans and friends for each other
  def self.are_they_friend_to_each_other?(user1,user2)
    return Friend.exists?(["(user_id = ? and friend_id = ?) and (user_id = ? and friend_id = ?)",user1,user2,user2,user1])
  end

  # following friend_id
  def self.add_as_my_friend(user_id,friend_id)
    Friend.create({:user_id=>user_id,:friend_id=>friend_id})
  rescue=>e
    logger.error("Error::friend.rb::add_as_my_friend")
    logger.error(e)
    return true
  end

  # unfollow friend_id
  def self.delete_my_friend(user_id,friend_id)
    friend = Friend.where(:user_id=>user_id,:friend_id=>friend_id).first
    friend.destroy
  rescue=>e
    logger.error("Error::friend.rb::delete_my_friend")
    logger.error(e)
    return true
  end
end
