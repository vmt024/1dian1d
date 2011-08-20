class GoalDigger < ActiveRecord::Base
  set_table_name :vote_histories

  attr_protected :user_id, :project_id, :push_or_hide
end
