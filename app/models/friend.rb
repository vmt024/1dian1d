class Friend < ActiveRecord::Base
 
  def name
    return User.exists?(["id = ?",self.user_id]) ? User.find(self.user_id).name : ""
  end
  
  def self.my_friends(user_id)
    return Friend.where("user_id = ?",user_id)
  end

  def self.are_they_friend?(user1,user2)
    return Friend.exists?(["(user_id = ? and friend_id = ?) or (user_id = ? and friend_id = ?)",user1,user2,user2,user1])
  end
  
  def self.are_they_friend_to_each_other?(user1,user2)
    return Friend.exists?(["(user_id = ? and friend_id = ?) and (user_id = ? and friend_id = ?)",user1,user2,user2,user1])
  end

  def self.add_as_my_friend(user_id,friend_id)
    unless Friend.are_they_friend?(user_id,friend_id)
      Friend.create({:user_id=>user_id,:friend_id=>friend_id})
    end
  end

  def self.delete_my_friend(user_id,friend_id)
    friend = Friend.where(:user_id=>user_id,:friend_id=>friend_id).first
    friend.destroy
  end
end
