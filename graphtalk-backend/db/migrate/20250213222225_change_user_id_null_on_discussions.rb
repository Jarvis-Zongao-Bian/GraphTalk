class ChangeUserIdNullOnDiscussions < ActiveRecord::Migration[8.0]
  def change
    change_column_null :discussions, :user_id, true
  end
end
